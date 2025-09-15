# Secured-User App

## Overview:
Secured-User is an iOS app built with Swift, UIKit and Combine, following the MVVM architecture.  

The app has the following functionalities:
- User authentication (login).
- Fetching and displaying a paginated list of users.
- Store and retrieval token using Keychain.
- Unit tests covering core business logic (login, users list parsing, token management).

---

## Covering Technologies:
- Technology: Swift, UIKit, Combine, Storyboard, and CocoaTouch
- Utilitities: Keychain, Pagination, Generics, Unit Testing, Loading Indicator, Pull down to refresh etc

---

## Architecture:

The app follows MVVM (Model-View-ViewModel):

- Model: Represents data structures such as User, LoginResponseModel, UsersResponse.
- ViewModel: Handles business logic and communicates with the network layer.
- View: UIs that react to data from the ViewModel..
- Network Layer: Handles API calls. It has services and clients that communicate with the backend and return data to the ViewModel.
- Utilities: Extensions, REsources and global components for UI and error handling

---

## How to Run this Project?

1. Clone the repository:
2. Open to the Xcode
3. Change the Bundle identifier and team name by yours. Project navigator UserDirecotry -> Targets -> Signing & Capabilities

---

## Limitations:

1. You may encounter an error "API key missing" for reaching out the limit of reqres free plan. For resolving, you can change the api key from App: UserDirectory -> Network -> Network Client (from getHeader method, change the value for "x-api-key")
2. The app is created for demo purpose using reqres apis
3. Unit test coverage is around 50%
4. UI is not fully polished.
5. Error handling is mimimal

