//  PixieImage.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aum-chauhan-175

import SwiftUI

/// A SwiftUI view that fetches and displays an image from a URL with caching support.
///
/// - Parameters:
///   - urlString: The URL string of the image to fetch and display.
///   - cacheKey: The cache key for the fetched image.
///
/// Example Usage:
///
///     PixieImage(urlString: "https://example.com/image.jpg", cacheKey: "uniqueKey")
///
@available(iOS 15.0, *)
public struct PixieImage<Placeholder>: View where Placeholder : View {
    
    public let placeholder: Placeholder?
    
    @StateObject private var viewModel : PixieImageViewModel
    
    /// Use the `PixieImage` view by initializing it with the image URL and a cache key. This view
    /// handles the image fetching and display process while utilizing caching to optimize performance.
    public init(_ urlString: String, cacheKey: String) where Placeholder == EmptyView  {
        _viewModel = StateObject(wrappedValue: PixieImageViewModel(url: urlString, key: cacheKey))
        self.placeholder = nil
    }
    
    /// Use the `PixieImage` view by initializing it with the image URL, a cache key, and a
    /// placeholder view. While the image is being fetched, the placeholder view is displayed.
    public init(_ urlString: String, cacheKey: String, @ViewBuilder placeholder: () -> Placeholder?) {
        _viewModel = StateObject(wrappedValue: PixieImageViewModel(url: urlString, key: cacheKey))
        self.placeholder = placeholder()
    }
    
    public var body: some View {
        ZStack {
            if viewModel.isLoading {
                if let placeholder {
                    // Placeholder view.
                    placeholder
                } else {
                    // Default placeholder
                    ProgressView()
                }
            } else if let image = viewModel.image {
                // Downloaded image
                Image(uiImage: image)
                    .resizable()
            } else {
                // Exception
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.gray)
            }
        }
    }
}
