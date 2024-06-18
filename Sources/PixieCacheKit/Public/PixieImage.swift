//  PixieImage.swift
//
//  Author: Aum Chauhan
//  Date: 20/8/2023
//  GitHub: https://github.com/aumChauhan

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
    
    // MARK: - Properties
    
    let placeholder: Placeholder?
    @StateObject private var viewModel : PixieImageViewModel
    
    // MARK: - Initializers
    
    /// Use the `PixieImage` view by initializing it with the image URL and a cache key. This view
    /// handles the image fetching and display process while utilizing caching to optimize performance.
    init(_ urlString: String, cacheKey: String) where Placeholder == EmptyView  {
        _viewModel = StateObject(wrappedValue: PixieImageViewModel(url: urlString, key: cacheKey))
        self.placeholder = nil
    }
    
    /// Use the `PixieImage` view by initializing it with the image URL, a cache key, and a
    /// placeholder view. While the image is being fetched, the placeholder view is displayed.
    init(_ urlString: String, cacheKey: String, @ViewBuilder placeholder: () -> Placeholder?) {
        _viewModel = StateObject(wrappedValue: PixieImageViewModel(url: urlString, key: cacheKey))
        self.placeholder = placeholder()
    }
    
    // MARK: - View Body
    
    public var body: some View {
        if viewModel.isLoading {
            if let placeholder {
                placeholder
            } else {
                ProgressView()
            }
        } else if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.gray)
        }
    }
}
