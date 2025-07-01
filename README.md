# Vend

`Vend` is an iOS application developed using `SwiftUI`. It displays photos retrieved from an API and inserts ads at specific positions in the list.

## Features

- Fetch the photos and titles from the server
- Insert an ad at every index ending in 5, 7, or 8.

## Tech Stack

- `MVVM (Model-View-ViewModel)`: Adopted as the architectural pattern.
-	`Async/await`: Used for making API calls.
-	`Dependency injection`: Applied when injecting the API service into the view model.
-	`Singleton`: Used for the single-instance Ad Manager.
-	`SDWebImage`: Utilized for fetching and caching images.
-	`GlobalNetworking`: Used for handling API requests. (This is my own networking framework that I created: [GlobalNetworking](https://github.com/cankurtur/GlobalNetworking))
-	`GoogleMobileAds`: Integrated for managing ads.
  
## Architecture Overview:
![image](https://github.com/user-attachments/assets/7f2fd6e7-3885-4feb-88ef-5f518a2aec57)

The app has one main module called `PhotoList`. Inside this module, we have both the `View` and `ViewModel` components.

`PhotoListView`:
- When the view loads, the initial API call is triggered using the `.task` modifier.
- This call fetches the first 10 items from the API.
- As the user scrolls down, the next 10 items are fetched again.
  
`PhotoListViewModel`:
- The ViewModel contains a `PhotoListService` to handle API calls.
-	Once data is successfully fetched, the `handleSuccessResponse` function is triggered.

`handleSuccessResponse`:
-	This function is responsible for inserting ads into the newly fetched 10 items at specific positions.
-	It uses the `latestIndex` property, which tracks the count of the current display items.
-	Initially, the display array is empty, so `latestIndex` is 0.
-	After the first successful fetch, the array grows to 13 items, and the `latestIndex` is 13 now which is the index we need to append new items.
-	A while loop is used to build a temporary result array by inserting either photo items or ads. It checks `latestIndex` % 10 to determine if an ad should be inserted at positions ending in 5, 7, or 8 (index positions 4, 6, 7).
-	Ads are fetched from the `AdManager` during this process.
-	Once the 10-item batch is fully processed and ads are inserted in the correct positions, the temporary array is appended to the main display items on the main thread.

`AdManager`:
- `AdManager` is a singleton that manages fetching banner ads from `GoogleMobileAds`.
-	It maintains a `bannerItems` array and a `currentBannerIndex` to track which ad to use next.
- The `AdManager` uses a pooling strategy. Ads are kept in memory and not removed to retain their `delegate` references.
-	Ads are initially added to the pool with a `loading` state.
-	Since the banner’s state is a `@Published` property, any change in status automatically updates the UI.
-	Each banner ad remains valid for 1 hour. After expiration, the `didFailToReceiveAdWithError` delegate method updates its status to fail.
-	`GoogleMobileAds` will attempt to refresh ads every 2–3 minutes via the `bannerViewDidReceiveAd` method.
- `bannerViewDidRecordImpression` simply logs to the console that the ad was just shown.

## Technial Decisions

- Using `PhotoListService` increases testability. During testing, `PhotoListService` can be mocked, allowing for the modification of network request responses.
-	In `NetworkManagerProtocol`, the `associatedtype` is used to restrict `endpoint` items for the `NetworkManager`. This approach ensures that each module has only the relevant endpoint items.
-	In alignment with SOLID principles, `PhotoListService` is injected into the `PhotoListViewModel`.
-	To safeguard sensitive information such as API keys and base URLs, a `Config` file was created. This approach centralizes the management of sensitive values and ensures they are securely handled within the application, preventing direct access to these values

## Trade-offs
### Not using Singleton for NetworkManager
The `NetworkManager` could be used with a `CompositionRoot` singleton class. Since the `NetworkManager` is thread-safe, it would be possible to create a `CompositionRoot` singleton and add the `NetworkManager` as a `lazy` variable. This way, the `NetworkManager` would be accessible throughout the app via the singleton.

However, instead of using a singleton, I chose to create a `NetworkManager` instance inside the `PhotoListService`.

- Disadvantages of this approach:
  - A new instance of the `NetworkManager` is created whenever a new screen is initialized.
  - These instances are retained in memory, which could lead to slightly higher resource usage.

- Why I avoided using a singleton:
  - Increased testability: Creating the `NetworkManager` inside the service provider allows for better dependency injection and easier mocking during testing.
  - Scoped instances: Each module can have its own relevant services using `associatedtype` in the `NetworkManagerProtocol`, ensuring a more modular and maintainable code structure.
  - Performance is not a concern: The app supports iOS 16 and later, meaning the target devices are powerful enough to handle multiple instances efficiently.
  - Singletons are hard to test: A singleton instance is globally shared, making it difficult to isolate and mock dependencies during testing.

This approach prioritizes testability and modularity over minor performance optimizations. 

### Pagination
The `JSONPlaceholder` API currently supports pagination. Here’s the documentation: https://github.com/typicode/json-server.
Instead of fetching all photos in a single request and inserting ads at every 4th, 6th, and 7th index, I prefer using pagination.

- Disadvantages of this approach:
  - An API call is required whenever the user scrolls down.
  - Ad insertion must be handled with each new response.

- Advantages of this approach:
  - Reduces fetch time during app launch, as we only load data when the user scrolls. This prevents downloading unnecessary data.
  - Inserting items directly into the displayed list at fixed positions (e.g., 4, 6, 7) may cause UI issues such as debouncing or layout shifts. Instead, I fetch 10 photos, insert ad items into the list, and then append the modified list to the actual display items, ensuring smoother rendering and a better user experience.
  
## Ideas for Improvement
- `Combine` can be used to automate the `AdManager`. New ads are published to subscribers, and all view models subscribe to the current ad items. The `AdManager` automatically refreshes the ad pool when it is about to run out and publishes the new values to its subscribers.

## Optional Features
- Debug/Release scheme types were added to configure the app for different environments.

## Notes
- The response from the JSONPlaceholder API contains invalid image URLs. For example, this URL — https://via.placeholder.com/150/771796 — does not open or load properly.









