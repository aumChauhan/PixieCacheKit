//  NetworkUtility.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aumChauhan

import Foundation
import SwiftUI

/// A utility class for handling network-related operations within PixieCacheKit.
@available(iOS 15.0, *)
public class NetworkUtility {
    
    private init() { }
    
    public static let shared = NetworkUtility()
    
    /// Asynchronously download an image from a URL.
    public func asyncImageDownload(urlString: String) async throws -> UIImage {
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
