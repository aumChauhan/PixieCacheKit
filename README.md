![IconForReadMeFile](https://github.com/aum-chauhan-175/PixieCacheKit/assets/83302656/7803d6bb-3890-4d01-bdde-5045994d03d4)
# PixieCacheKit

Simplify image caching with PixieCacheKit.

## Features

- **Flexible Caching Options:** Choose between memory-based caching or file-based caching, adapting to your app's requirements.
- **Cache Management Functions:** Utilize built-in functions to manage cached data, including checking cache size and clearing cache when needed.
- **Efficient Performance:** Enhance app performance by optimizing image loading times.
- **Simple Integration:** Integrate PixieCacheKit seamlessly into your app with straightforward setup.
- **Smart Image Fetching:** Intelligently fetch images, reducing network requests and improving loading times.

## Requirements

- Xcode 11 and above
- iOS 15 and above

## Installation

To integrate PixieCacheKit into your project, you can use `CocoaPods` or `Swift Package Manager`.

### CocoaPods

Add the following line to your Podfile:

```ruby
pod 'PixieCacheKit'
```

Then run `pod install` to install the framework.

### Swift Package Manager

In Xcode, go to File -> Swift Packages -> Add Package Dependency and enter the repository URL:

```other
https://github.com/aum-chauhan-175/PixieCacheKit.git
```

## Getting Started

1. Import the framework: `import PixieCacheKit`.
2. In SwiftUI App, first `import PixieCacheKit`, then configure your caching options using `PixieCacheKit`.

Example:

```swift
import SwiftUI
import PixieCacheKit

@main
struct MyApp: App {
    init() {
        // Configure to use a custom directory for file-based image caching.
        PixieCacheKit.configure(directoryName: "MyAppCache")
      
        // OR 
      
        // Use a specific memory limit for image caching.
        // `PixieCacheKit.configure(memoryLimit: 100)`
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Using `PixieImage` View

The `PixieImage` view simplifies image fetching, display, and caching in your iOS app. It provides two initializers to facilitate different use cases. This view takes an image URL and a cache key, allowing you to efficiently handle image data while benefiting from caching options.

### Initializer 1: Fetch and Cache Image

```swift
PixieImage("https://example.com/image.jpg", cacheKey: "uniqueKey")
```

### Initializer 2: Fetch with Placeholder

```swift
PixieImage("https://example.com/image.jpg", cacheKey: "uniqueKey") {
    Text("Loading...") // Placeholder view
}
```

> NOTE : You can enhance your `PixieImage` view by using SwiftUI view modifiers.

## PixieCacheManager Functions

The `PixieCacheManager` offers functions to manage cached data and retrieve cache-related information. This manager is designed to simplify cache management tasks and provide insights into your app's cached content.

### Clear Cache Data

Use the `clearCacheData` function to remove all cached image data from the local cache directory.

```swift
PixieCacheManager.clearCacheData()
```

### Get Cache Directory Size

Retrieve the size of the cache directory using the `getCacheDirectorySize` function.

```swift
let cacheSize = PixieCacheManager.getCacheDirectorySize()
```

## License

PixieCacheKit is released under the [MIT License](LICENSE).
