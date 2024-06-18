//
// PixieCacheKit.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 20/8/2023
//

import Foundation

/// Provides utilities for image caching and configuration.
///
/// Use this class to configure image caching parameters and utility operations during app launch.
///
/// - Note: If not configured explicitly, PixieCacheKit defaults to using 'PixieImageCache' as the cache directory name, `.jpeg` as the image format, and file manager storage for caching.
@available(iOS 15.0, *)
public class PixieCacheKit {
    private init() {}
    
    /// Configure PixieCacheKit for file-based image caching.
    ///
    /// Use this method to specify a custom cache directory and image format for file-based caching.
    ///
    /// - Parameters:
    ///   - directoryName: The name of the custom cache directory.
    ///   - imageFormat: The image format (.jpeg or .png) for file manager caching.
    ///
    /// Example usage:
    /// ```swift
    /// PixieCacheKit.configure(directoryName: "CustomCache", imageFormat: .png)
    /// ```
    public static func configure(directoryName: String, imageFormat: ImageFormat) {
        CacheManager.shared.cacheDirectoryName = directoryName
        CacheManager.shared.imageFormat = imageFormat
        CacheManager.shared.storageLocation = .fileManager
        CacheManager.shared.createCacheDirectory()
        
        print("PIXIE_CACHE_KIT_DEBUG: FILE-BASED IMAGE CACHING CONFIGURED SUCCESSFULLY.")
    }
    
    /// Configure PixieCacheKit for memory-based image caching.
    ///
    /// Use this method to set a specific memory limit for image caching(in megaBytes).
    ///
    /// - Parameter memoryLimit: The maximum memory limit for image caching.
    ///
    /// Example usage:
    /// ```swift
    /// PixieCacheKit.configure(memoryLimit: 100) // Sets memory limit to 100 MB
    /// ```
    public static func configure(memoryLimit: Int) {
        // Configuring storage location.
        CacheManager.shared.storageLocation = .memory
        
        // Configuring memory limit.
        CacheManager.memoryLimit = memoryLimit
        
        print("PIXIE_CACHE_KIT_DEBUG: MEMORY BASED IMAGE CACHING CONFIGURED SUCCESSFULLY.")
    }
    
    /// Disable debug prints during image operations.
    ///
    /// Use this method to suppress debug print statements during image downloading and retrieval.
    static func disableDebugPrints() {
        CacheManager.shared.disableDebugPrint()
    }
}
