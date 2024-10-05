# Recipe App

## Specs

* Language: Swift
* UI Framework: SwiftUI
* Minimum supported iOS version: 16.0
* Orientation support: Portrait And Landscape
* Device support: iPhone and iPad
* Dependencies required: None
    * Feel free to build using native APIs
* The Recipe JSON: [Link](https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json)

## Steps to run

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Install dependencies using Swift Package Manager (if not already done).
4. Build and run the project on your preferred simulator or device.

## Focus Areas
Our primary focus areas for this project were:

Networking Layer: Created a custom networking layer to handle API requests efficiently. This includes:

1. A separate NetworkLayer package
NetworkEndpoints for defining API endpoints
INetworkRequest for creating and managing network requests
IRecipeNetworkService for handling recipe-specific network operations


2. Image Caching: Implemented image caching using NSCache to improve performance and reduce network usage when displaying recipe images.
3. MVVM Architecture: We utilized the MVVM (Model-View-ViewModel) pattern, with a ViewModel acting as an intermediary between the networking layer and the UI.

## Time Spent
Approximate time spent on this project: ~4 hours

## Trade-offs and Decisions

Custom Networking Layer vs. Third-party Libraries: Decided to create a custom networking layer instead of using a third-party library. This gives us more control over the implementation but required more development time.
NSCache for Image Caching: Chose NSCache for its simplicity and built-in memory management. However, this doesn't persist cached images between app launches.

## Weakest Part of the Project

The weakest part of the project is the image caching implementation. I used NSCache for in-memory caching, which provides some performance benefits but has limitations:

1. It doesn't persist cached images between app launches, potentially leading to unnecessary network requests when the app restarts.
2. There is no disk caching, which could provide more robust caching capabilities but comes with its own performance considerations.
3. While third-party libraries like Kingfisher could offer more advanced caching features, I chose to implement caching by myself to demonstrate understanding of iOS development concepts.

## External Code and Dependencies

* swift-tagged: Used this third-party library to enhance type safety in codebase.
* NetworkLayer Package: Created this custom package to encapsulate our networking logic.

## Additional Information

The project follows Swift best practices and coding conventions.