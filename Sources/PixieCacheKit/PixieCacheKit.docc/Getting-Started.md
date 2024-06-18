# Getting Started 

Configure PixieCacheKit for optimized image caching.

## Overview

Configure caching settings at app launch to optimize image loading and storage management.

### Configure Caching Options

To get started, import PixieCacheKit at the beginning of your SwiftUI app file. In the initializer of your `App` struct, configure the caching options using configuration methods:

```swift
import SwiftUI
import PixieCacheKit

@main
struct MyApp: App {
    init() {
        // Configure to use a custom directory for file-based image caching.
        PixieCacheKit.configure(directoryName: "MyAppCache", imageFormat: .jpeg)
      
      
        // Use a specific memory limit for image caching.
        PixieCacheKit.configure(memoryLimit: 100)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
> If not configured explicitly, PixieCacheKit defaults to using 'PixieImageCache' as the cache directory name, `.jpeg` as the image format, and file manager storage for caching.
