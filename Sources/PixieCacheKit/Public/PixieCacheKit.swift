//  PixieCacheKit.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aum-chauhan-175
import Foundation

@available(iOS 15.0, *)
public struct PixieCacheKit {
    private init() { }
    
    /// Configure PixieCacheKit to use a custom directory for file-based image caching.
    /// - Parameter directoryName: The name of the custom cache directory.
    public static func configure(directoryName: String) {
        // Configuring directory name
        CacheManager.shared.cacheDirectoryName = directoryName
        
        // Configuring storage location.
        CacheManager.shared.storageLocation = .fileManager
        
        CacheManager.shared.createCacheDirectory()
        
        print("PIXIE_CACHE_KIT_DEBUG: FILE-BASED IMAGE CACHING CONFIGURED SUCCESSFULLY.")
    }
    
    /// Configure PixieCacheKit to use a specific memory limit for image caching.
    /// - Parameter memoryLimit: The maximum memory limit for image caching in megabytes.
    public static func configure(memoryLimit: Int) {
        // Configuring storage location.
        CacheManager.shared.storageLocation = .memory
        
        // Configuring memory limit.
        CacheManager.memoryLimit = memoryLimit
        
        print("PIXIE_CACHE_KIT_DEBUG: MEMORY BASED IMAGE CACHING CONFIGURED SUCCESSFULLY.")
    }
    
    /// Disable debug prints during image downloading and retrieval.
    ///
    /// The `disableDebugPrints()` function allows you to suppress debug print statements
    /// specifically during the process of image downloading and retrieval. This can help
    /// improve code clarity and reduce unnecessary output in your app's logs.
    public static func disableDebugPrints() {
        CacheManager.shared.disableDebugPrint()
    }
}
