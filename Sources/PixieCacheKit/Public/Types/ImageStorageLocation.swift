//
// ImageStorageLocation.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 18/6/2024
//

import Foundation

/// Enum representing different storage options for images in PixieCacheKit.
@available(iOS 15.0, *)
@frozen public enum ImageStorageLocation {
    /// Store the image in memory using NSCache for quick access and reduced load times.
    /// Recommended for frequently accessed images or smaller images that can fit in memory.
    case memory
    
    /// Store the image in the file manager's cache directory for persistent storage.
    /// Recommended for larger images or less frequently accessed images.
    case fileManager
}
