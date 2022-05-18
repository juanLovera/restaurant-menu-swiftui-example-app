# Restaurant Menu - SwiftUI Sample App
This is a small SwiftUI sample app that presents a mocked McDonald's menu. It features lists, LazyHStack and a custom sync/await network manager.

### Minimum Requirements 
Xcode 13.1, Swift 5 and iOS 15.

### Technical Design
-This project follows a simple MVVM architecture with 2 main views: 
 - Main Menu: list of menu categories and products. Each category has a scroll view with a LazyHStack containing products images and titles. Images are loaded asynchronically and locally cached.
 ![Simulator Screen Shot - iPhone 12 Pro - 2022-05-17 at 23 50 42](https://user-images.githubusercontent.com/4535491/168949001-da40b6cb-197e-4616-9a7a-c8c162065784.png)
 
 - Product Details: modal view with image, price, title and description. 
![Simulator Screen Shot - iPhone 12 Pro - 2022-05-17 at 23 51 52](https://user-images.githubusercontent.com/4535491/168948991-6aaefe28-4cb7-41c7-9a48-d80fe9244afe.png)

-Each View Model has its own protocol so unit tests can be easily added later.

-The custom network manager uses sync/await for callbacks and Codable for JSON parsing. McDonald's mock API is provided by trio.dev: [https://mcdonalds.trio.dev/menu](https://mcdonalds.trio.dev/menu)

### Dependencies

This project uses Swift Package Manager and it has 2 dependencies: 

 - https://github.com/markiv/SwiftUI-Shimmer (effect used in loading screen).
 - https://github.com/SDWebImage/SDWebImageSwiftUI.git (image loading/caching).

