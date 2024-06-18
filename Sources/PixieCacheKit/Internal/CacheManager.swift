//
// CacheManager.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 20/8/2023
//

import Foundation
import SwiftUI

/// Manages caching and retrieval of images.
@available(iOS 15.0, *)
internal class CacheManager {
    
    private init() { }
    
    // MARK: - Properties
    
    static let shared = CacheManager()
    
    /// Format for cached images.
    var imageFormat: ImageFormat = .jpeg
    
    /// Storage location for images.
    var storageLocation: ImageStorageLocation = .fileManager
    
    /// Describes the status of debug prints is enabled or disabled.
    var debugPrint: Bool = true
    
    /// Name of the cache directory used for file-based image caching.
    var cacheDirectoryName = "PixieImageCache"
    
    /// Maximum memory capacity allocated for caching images.
    static var memoryLimit: Int = 50
    
    // MARK: - File Manager Handling
    
    /// Create a directory if it doesn't exist at the specified path.
    ///
    /// - Note: Uses the caches directory for storage.
    func createCacheDirectory() {
        guard let cacheURL = getCacheDirectoryPath() else { return }
        
        if !FileManager.default.fileExists(atPath: cacheURL.path) {
            do {
                try FileManager.default.createDirectory(at: cacheURL, withIntermediateDirectories: true)
            } catch {
                print("PIXIE_CACHE_KIT_DEBUG: FAIL TO CREATE DIRECTORY AT '\(cacheURL.path)'. \(error.localizedDescription)")
            }
        }
    }
    
    /// Returns the absolute file path of cached directory.
    ///
    /// - Returns: `URL` representing the cache directory path.
    private func getCacheDirectoryPath() -> URL? {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(cacheDirectoryName)
    }
    
    /// Retrieves the file path for a cached image.
    ///
    /// - Parameter key: Unique identifier for the cached image.
    /// - Returns: URL representing the file path of the cached image.
    private func getImagePath(key: String) -> URL? {
        guard let cacheURL = getCacheDirectoryPath() else { return nil }
        
        return cacheURL.appendingPathComponent(key + imageFormat.rawValue)
    }
    
    /// Appends an image to the cache directory.
    ///
    /// - Parameters:
    ///   - image: Image to be cached.
    ///   - key: Unique identifier for the cached image.
    func appendImageToCacheDirectory(image: UIImage, key: String) {
        guard let data = image.pngData(),
              let cacheURL = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: cacheURL)
        } catch {
            print("PIXIE_CACHE_KIT_DEBUG: FAIL TO APPEND '\(key)' AT '\(cacheURL)'. \(error.localizedDescription)")
        }
    }
    
    /// Retrieves an image from the cache directory.
    ///
    /// - Parameter key: Unique identifier for the cached image.
    /// - Returns: UIImage object if image exists, otherwise nil.
    func getImageFromCacheDirectory(key: String) -> UIImage? {
        guard
            let cacheURL = getImagePath(key: key),
            FileManager.default
                .fileExists(atPath: cacheURL.path)
        else {
            print("PIXIE_CACHE_KIT_DEBUG: FAIL TO RETRIEVE IMAGE.")
            return nil
        }
        
        return UIImage(contentsOfFile: cacheURL.path)
    }
    
    // MARK: - Cache Management Functions
    
    /// Removes all cached data from the cache directory.
    func clearCacheData() {
        do {
            guard let cacheURL = getCacheDirectoryPath() else {
                throw URLError(.cancelled)
            }
            
            let directoryContents = try FileManager.default
                .contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil, options: [])
            
            for file in directoryContents {
                do {
                    try FileManager.default.removeItem(at: file)
                }
                catch {
                    print("PIXIE_CACHE_KIT_DEBUG: SOMETHING WENT WRONG '\(error.localizedDescription)'.")
                }
            }
        } catch {
            print("PIXIE_CACHE_KIT_DEBUG: FAIL TO CLEAR CACHE DATA '\(error.localizedDescription)'.")
        }
    }
    
    /// Calculates the total size of the cache directory.
    ///
    /// - Returns: Size of the cache directory in bytes.
    func getCacheDirectorySize() -> Int {
        guard let cacheURL = getCacheDirectoryPath() else { return 0 }
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: cacheURL.path)
            var folderSize: Int64 = 0
            for content in contents {
                do {
                    let fullContentPath = cacheURL.path + "/" + content
                    let fileAttributes = try FileManager.default.attributesOfItem(atPath: fullContentPath)
                    folderSize += fileAttributes[FileAttributeKey.size] as? Int64 ?? 0
                } catch _ {
                    continue
                }
            }
            
            return Int(folderSize)
        } catch let error {
            print("PIXIE_CACHE_KIT_DEBUG: SOMETHING WENT WRONG '\(error.localizedDescription)'.")
            return 0
        }
    }
    
    // MARK: - NSCache Memory Management
    
    private var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = memoryLimit
        cache.totalCostLimit = 1024 * 1024 * memoryLimit
        return cache
    }()
    
    /// Caches an image in NSCache using the specified key.
    ///
    /// - Parameters:
    ///   - image: Image to be cached.
    ///   - key: Unique identifier for the cached image.
    func addCachedImage(image: UIImage, key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    /// Retrieves a cached image from NSCache based on the provided key.
    ///
    /// - Parameter key: Unique identifier for the cached image.
    /// - Returns: Cached UIImage object if exists, otherwise nil.
    func getCachedImage(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
    // MARK: - Utility
    
    /// Disables debug prints during image downloading and retrieval.
    func disableDebugPrint() {
        debugPrint = false
    }
}
