//  CacheManager.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aum-chauhan-175

import Foundation
import SwiftUI

@available(iOS 15.0, *)
public class CacheManager {
    
    private init() { }
    
    public static let shared = CacheManager()
    
    public var storageLocation: ImageStorageLocation = .fileManager
    
    /// Describes the status of debug prints.
    public var debugPrint: Bool = true
    
    // MARK: - File Manager
    
    ///  The name of the cache directory used by PixieCacheKit for file-based image caching.
    public var cacheDirectoryName = "PixieImageCache"
    public var imageFormat: ImageFormat = .jpeg

    /// Create a directory if it doesn't exist at the specified path.
    public func createCacheDirectory() {
        // Directory path.
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
    private func getCacheDirectoryPath() -> URL? {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(cacheDirectoryName)
    }
    
    /// Retrieves the file path for a cached image identified by the provided key.
    private func getImagePath(key: String) -> URL? {
        guard let cacheURL = getCacheDirectoryPath() else { return nil }
        
        return cacheURL.appendingPathComponent(key + imageFormat.rawValue)
    }
    
    /// Append an image in the specified directory with the given key(name).
    public func appendImageToCacheDirectory(image: UIImage, key: String) {
        guard let data = image.pngData(),
              let cacheURL = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: cacheURL)
        } catch {
            print("PIXIE_CACHE_KIT_DEBUG: FAIL TO APPEND '\(key)' AT '\(cacheURL)'. \(error.localizedDescription)")
        }
    }
    
    /// Retrieve an image from specified directory.
    public func getImageFromCacheDirectory(key: String) -> UIImage? {
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
    
    /// Remove all cached data from the cache directory.
    public func clearCacheData() {
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
    
    /// Calculate and return the total size of the cache directory in bytes.
    public func getCacheDirectorySize() -> Int {
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
    
    /// Disable debug prints during image downloading and retrieval.
    public func disableDebugPrint() {
        self.debugPrint = false
    }
    
    // MARK: - Memory
    
    /// Initialize maximum memory capacity allocated for cache images.
    public static var memoryLimit: Int = 50
    
    private var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = memoryLimit
        cache.totalCostLimit = 1024 * 1024 * memoryLimit
        return cache
    }()
    
    /// Cache an image in NSCache using the specified key.
    public func addCachedImage(image: UIImage, key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    /// Retrieve a cached image from NSCache based on the provided key.
    public func getCachedImage(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}

