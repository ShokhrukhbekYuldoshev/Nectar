# 🥕 Nectar

Online groceries shopping app built with Flutter, Firebase and Bloc pattern.

## NOTE

This project is still under development.

## ✨ Features

- [x] Authentication
- [x] Home
- [x] Categories
- [x] Products
- [x] Cart
- [x] Profile
- [x] Search
- [x] Favorites
- [x] Orders
- [x] Order Details
- [x] Reviews
- [x] Payment with Stripe
- [x] Settings
- [x] About
- [x] Contact
- [x] Notifications
- [x] Dark Mode
- [x] Localization (English, Russian)
- [x] Responsive UI
- [x] Animations
- [x] Firebase Cloud Messaging
- [x] Firebase Analytics
- [x] Firebase Crashlytics

## 🔰 Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase](https://firebase.google.com/docs/flutter/setup)

### Installation

1. Clone the repo

```sh
git clone
```

2. Install packages

```sh
flutter pub get
```

3. Mapbox is used for map. Go to https://www.mapbox.com/ and create a new token. Then, create a file named secrets.dart in lib folder and add the following code:

```dart
const String mapboxAccessToken = {YOUR_MAPBOX_ACCESS_TOKEN};
```

4. Run the app

```sh
flutter run
```

## 📦 Packages

| Package                                                                   | Version | Description                                                                                                                                                        |
| ------------------------------------------------------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [bloc](https://pub.dev/packages/bloc)                                     | 8.1.2   | A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.                                                    |
| [cached_network_image](https://pub.dev/packages/cached_network_image)     | 3.2.3   | A flutter library to show images from the internet and keep them in the cache directory.                                                                           |
| [carousel_slider](https://pub.dev/packages/carousel_slider)               | 4.2.1   | A carousel slider widget, support infinite scroll and custom child widget, with autoplay feature.                                                                  |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore)               | 4.8.4   | A Flutter plugin to use the Cloud Firestore API, a cloud-hosted, NoSQL database with live synchronization and offline support on Android and iOS.                  |
| [dio](https://pub.dev/packages/dio)                                       | 5.3.1   | A powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.                                       |
| [equatable](https://pub.dev/packages/equatable)                           | 2.0.5   | Simplify Equality Comparisons.                                                                                                                                     |
| [firebase_auth](https://pub.dev/packages/firebase_auth)                   | 4.7.2   | Flutter plugin for Firebase Auth, enabling Android and iOS authentication using passwords, phone numbers and identity providers like Google, Facebook and Twitter. |
| [firebase_core](https://pub.dev/packages/firebase_core)                   | 2.15.0  | Flutter plugin for Firebase Core, enabling connecting to multiple Firebase apps.                                                                                   |
| [firebase_storage](https://pub.dev/packages/firebase_storage)             | 11.2.5  | Flutter plugin for Firebase Cloud Storage, a powerful, simple, and cost-effective object storage service for Android and iOS.                                      |
| [flutter](https://flutter.dev/)                                           | 3.10.6  | Flutter SDK.                                                                                                                                                       |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                     | 8.1.3   | State management library for Dart that works with Flutter.                                                                                                         |
| [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)   | 6.0.0   | Flutter plugin for Facebook Auth, enabling Android and iOS authentication using Facebook SDK.                                                                      |
| [flutter_map](https://pub.dev/packages/flutter_map)                       | 5.0.0   | A Dart implementation of Leaflet for Flutter apps.                                                                                                                 |
| [flutter_svg](https://pub.dev/packages/flutter_svg)                       | 2.0.7   | SVG parsing, rendering, and widget library for Flutter.                                                                                                            |
| [geolocator](https://pub.dev/packages/geolocator)                         | 9.0.2   | Geolocation plugin for Flutter. Provides settings for optimizing performance or battery.                                                                           |
| [google_sign_in](https://pub.dev/packages/google_sign_in)                 | 6.1.4   | Flutter plugin for Google Sign-In, a secure authentication system for signing in with a Google account on Android and iOS.                                         |
| [hive](https://pub.dev/packages/hive)                                     | 2.2.3   | A lightweight and blazing fast key-value database written in pure Dart.                                                                                            |
| [hive_flutter](https://pub.dev/packages/hive_flutter)                     | 1.1.0   | Hive database implementation for Flutter.                                                                                                                          |
| [intl_phone_field](https://pub.dev/packages/intl_phone_field)             | 3.2.0   | A flutter package for international phone number input.                                                                                                            |
| [latlong2](https://pub.dev/packages/latlong2)                             | 0.9.0   | A package for geographical point calculations, e.g. distances between points, bearing.                                                                             |
| [package_info_plus](https://pub.dev/packages/package_info_plus)           | 4.0.2   | Flutter plugin for querying information about the application package, such as CFBundleVersion on iOS or versionCode on Android.                                   |
| [pinput](https://pub.dev/packages/pinput)                                 | 2.3.0   | A flutter package for custom beautiful pin code fields.                                                                                                            |
| [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator)   | 1.1.0   | A customizable and smooth page indicator for Flutter.                                                                                                              |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | 0.13.1  | A package which simplifies the task of updating your Flutter app's launcher icon.                                                                                  |

## 🔗 Resources

- [Design](<https://www.figma.com/file/lA6Pp8ZQ9XCZeima0laz7Y/Online-Groceries-App-UI-(Community)>)

## 📱 Screenshots

<!-- later -->

## 📝 License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

## 👨🏽‍💻 Author(s)

👤 Shokhrukhbek Yuldoshev

- Github: [@ShokhrukhbekYuldoshev](https://github.com/ShokhrukhbekYuldoshev)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Please ⭐️ this repository if this project helped you!
