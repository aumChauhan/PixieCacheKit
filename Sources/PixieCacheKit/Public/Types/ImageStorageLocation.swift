//
// ImageStorageLocation.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 18/6/2024
//

import Foundation

/// Represents a different storage options for images in PixieCacheKit.
///
/// - Note: Use `memory` for storing images in NSCache for quick access and reduced load times,
///   suitable for frequently accessed or smaller images. Use `fileManager` for larger images
///   or less frequently accessed images, storing them in the file manager's cache directory
///   for persistent storage.
@available(iOS 15.0, *)
@frozen public enum ImageStorageLocation {
    /// Store images in NSCache for fast access.
    case memory
    
    /// Store images in the file manager's cache directory for persistent storage.
    case fileManager
}
