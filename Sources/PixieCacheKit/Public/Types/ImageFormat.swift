//
// ImageFormat.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 25/8/2023
//

import Foundation

/// Represents supported image formats in PixieCacheKit.
@available(iOS 15.0, *)
@frozen public enum ImageFormat: String {
    /// Stores images in JPEG format.
    case jpeg = ".jpeg"
    
    /// Stores images in PNG format.
    case png = ".png"
}
