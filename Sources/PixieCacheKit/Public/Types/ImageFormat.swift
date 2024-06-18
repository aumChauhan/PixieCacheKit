//
// ImageFormat.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 25/8/2023
//

import Foundation

/// Enumeration representing supported image formats in PixieCacheKit.
@available(iOS 15.0, *)
@frozen public enum ImageFormat: String {
    /// `jpeg` stores images in .jpeg format.
    case jpeg = ".jpeg"
    
    /// `png` stores images in .png format.
    case png = ".png"
}
