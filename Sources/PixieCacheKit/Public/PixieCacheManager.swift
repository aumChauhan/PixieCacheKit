//  PixieCacheManager.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aum-chauhan-175

import Foundation

@available(iOS 15.0, *)
public struct PixieCacheManager {
    private init() { }
    
    /// Remove all images from the cache directory.
    ///
    /// - The `clearCacheData()` function deletes all cached images and data from the cache directory
    /// within PixieCacheKit. Use this function to free up storage space or perform cache cleanup.
    public static func clearCacheData() {
        CacheManager.shared.clearCacheData()
    }
    
    /// Calculate and return the total size of the cache directory in bytes.
    ///
    /// - The `getCacheDirectorySize()` function calculates the total size of the cache directory
    /// within PixieCacheKit, including all cached images and data, and returns the size in bytes.
    /// This function can be useful for monitoring cache usage or performing cache management tasks.
    ///
    /// - Returns: The total size of the cache directory in bytes.
    public static func getCacheDirectorySize() -> Int {
        return CacheManager.shared.getCacheDirectorySize()
    }
}
