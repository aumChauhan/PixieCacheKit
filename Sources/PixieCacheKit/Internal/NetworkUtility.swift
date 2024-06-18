//
// NetworkUtility.swift
// PixieCacheKit: https://github.com/aumChauhan/PixieCacheKit.git
//
// Author: Aum Chauhan
// Created On: 20/8/2023
//

import Foundation
import SwiftUI

/// Handles network-related operations within PixieCacheKit.
@available(iOS 15.0, *)
internal class NetworkUtility {
    private init() {}
    
    static let shared = NetworkUtility()
    
    /// Asynchronously downloads an image from a URL.
    ///
    /// - Parameter urlString: The URL string from which to download the image.
    /// - Returns: A `UIImage` object representing the downloaded image.
    /// - Throws: An error if the URL is invalid or if there's an issue with downloading or decoding the image data.
    func asyncImageDownload(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let data = try? await URLSession.shared.data(from: url)
        
        guard let data else {
            throw URLError(.cannotDecodeRawData)
        }
        
        guard let image = UIImage(data: data.0) else {
            throw URLError(.cannotDecodeRawData)
        }
        
        return image
    }
}
