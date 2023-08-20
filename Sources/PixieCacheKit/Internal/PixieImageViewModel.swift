import Foundation
import SwiftUI
import UIKit

/// Enum representing different storage options for images in PixieCacheKit.
public enum ImageStorageLocation {
    /// Store the image in memory using NSCache for quick access and reduced load times.
    /// Recommended for frequently accessed images or smaller images that can fit in memory.
    case memory
    
    /// Store the image in the file manager's cache directory for persistent storage.
    /// Recommended for larger images or less frequently accessed images.
    case fileManager
}

@MainActor
@available(iOS 15.0, *)
public class PixieImageViewModel: ObservableObject {
    
    private let urlString: String
    private let imageKey: String
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        
        getImage()
    }
    
    /// Retrieve a cached image on basis of storage location.
    private func getImage() {
        if CacheManager.shared.storageLocation == .fileManager {
            if let savedImage = CacheManager.shared.getImageFromCacheDirectory(key: imageKey) {
                image = savedImage
                
                if CacheManager.shared.debugPrint {
                    print("PIXIE_CACHE_KIT_DEBUG: RETRIEVING IMAGE FROM FILE MANAGER.")
                }
            } else {
                // Downloading image, incase retrieving cached images goes fails.
                downloadImage()
                
                if CacheManager.shared.debugPrint {
                    print("PIXIE_CACHE_KIT_DEBUG: DOWNLOADING IMAGE.")
                }
            }
        } else if CacheManager.shared.storageLocation == .memory  {
            if let savedImage = CacheManager.shared.getCachedImage(key: imageKey) {
                image = savedImage
                
                if CacheManager.shared.debugPrint {
                    print("PIXIE_CACHE_KIT_DEBUG: RETRIEVING IMAGE FROM NSCACHE.")
                }
            } else {
                // Downloading image, incase retrieving cached images goes fails.
                downloadImage()
                
                if CacheManager.shared.debugPrint {
                    print("PIXIE_CACHE_KIT_DEBUG: DOWNLOADING IMAGE.")
                }
            }
        }
    }
    
    /// Download image from specified `urlString`.
    private func downloadImage() {
        Task {
            withAnimation { isLoading = true }
            
            do {
                let downloadedImage = try await NetworkUtility.shared.asyncImageDownload(urlString: urlString)
                
                withAnimation { image = downloadedImage }
                
                // Appending a cached image on basis of storage location
                if CacheManager.shared.storageLocation == .fileManager {
                    CacheManager.shared.appendImageToCacheDirectory(image: downloadedImage, key: imageKey)
                    
                } else if CacheManager.shared.storageLocation == .memory {
                    CacheManager.shared.addCachedImage(image: downloadedImage, key: imageKey)
                }
            } catch {
                print("PIXIE_CACHE_KIT_DEBUG: FAIL TO DOWNLOAD IMAGE \(error.localizedDescription).")
            }
            
            withAnimation { isLoading = false }
        }
    }
}

