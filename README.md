# 🥕 Nectar

Online groceries shopping app built with Flutter, Firebase and Bloc pattern.

## NOTE

This project is still under development.

## 🧾 Features

-   [x] Authentication
-   [x] Home
-   [x] Categories
-   [x] Products (List, Details)
-   [x] Stores (List, Details)
-   [x] Cart
-   [x] Profile
-   [x] Search
-   [x] Favorites
-   [ ] Orders
-   [ ] Order Details
-   [ ] Reviews
-   [ ] Payment
-   [ ] Tracking
-   [x] Settings
-   [x] About
-   [x] Support
-   [ ] Notifications
-   [ ] Dark Mode
-   [ ] Localization (English, Russian)
-   [x] Responsive UI
-   [ ] Animations
-   [ ] Firebase Analytics
-   [x] Firebase Crashlytics

## 🔰 Getting Started

### Prerequisites

-   [Flutter](https://flutter.dev/docs/get-started/install)
-   [Firebase](https://firebase.google.com/docs/flutter/setup)

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
| [cached_network_image](https://pub.dev/packages/cached_network_image)     | 3.3.0   | A flutter library to show images from the internet and keep them in the cache directory.                                                                           |
| [carousel_slider](https://pub.dev/packages/carousel_slider)               | 4.2.1   | A carousel slider widget, support infinite scroll and custom child widget, with autoplay feature.                                                                  |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore)               | 4.13.5  | A Flutter plugin to use the Cloud Firestore API, a cloud-hosted, NoSQL database with live synchronization and offline support on Android and iOS.                  |
| [dio](https://pub.dev/packages/dio)                                       | 5.4.0   | A powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.                                       |
| [equatable](https://pub.dev/packages/equatable)                           | 2.0.5   | Simplify Equality Comparisons.                                                                                                                                     |
| [firebase_auth](https://pub.dev/packages/firebase_auth)                   | 4.15.2  | Flutter plugin for Firebase Auth, enabling Android and iOS authentication using passwords, phone numbers and identity providers like Google, Facebook and Twitter. |
| [firebase_core](https://pub.dev/packages/firebase_core)                   | 2.24.2  | Flutter plugin for Firebase Core, enabling connecting to multiple Firebase apps.                                                                                   |
| [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics)     | 3.4.8   | Flutter plugin to use the Firebase Crashlytics API.                                                                                                                |
| [firebase_storage](https://pub.dev/packages/firebase_storage)             | 11.2.5  | Flutter plugin for Firebase Cloud Storage, a powerful, simple, and cost-effective object storage service for Android and iOS.                                      |
| [flutter](https://flutter.dev/)                                           | 3.16.0  | Flutter SDK.                                                                                                                                                       |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                     | 8.1.3   | State management library for Dart that works with Flutter.                                                                                                         |
| [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)   | 6.0.3   | Flutter plugin for Facebook Auth, enabling Android and iOS authentication using Facebook SDK.                                                                      |
| [flutter_map](https://pub.dev/packages/flutter_map)                       | 6.1.0   | A Dart implementation of Leaflet for Flutter apps.                                                                                                                 |
| [flutter_svg](https://pub.dev/packages/flutter_svg)                       | 2.0.9   | SVG parsing, rendering, and widget library for Flutter.                                                                                                            |
| [geolocator](https://pub.dev/packages/geolocator)                         | 10.1.0  | Geolocation plugin for Flutter. Provides settings for optimizing performance or battery.                                                                           |
| [google_sign_in](https://pub.dev/packages/google_sign_in)                 | 6.2.0   | Flutter plugin for Google Sign-In, a secure authentication system for signing in with a Google account on Android and iOS.                                         |
| [hive](https://pub.dev/packages/hive)                                     | 2.2.3   | A lightweight and blazing fast key-value database written in pure Dart.                                                                                            |
| [hive_flutter](https://pub.dev/packages/hive_flutter)                     | 1.1.0   | Hive database implementation for Flutter.                                                                                                                          |
| [image_picker](https://pub.dev/packages/image_picker)                     | 1.0.4   | An image picker plugin for Flutter.                                                                                                                                |
| [intl_phone_field](https://pub.dev/packages/intl_phone_field)             | 3.2.0   | A flutter package for international phone number input.                                                                                                            |
| [latlong2](https://pub.dev/packages/latlong2)                             | 0.9.0   | A package for geographical point calculations, e.g. distances between points, bearing.                                                                             |
| [package_info_plus](https://pub.dev/packages/package_info_plus)           | 5.0.1   | Flutter plugin for querying information about the application package, such as CFBundleVersion on iOS or versionCode on Android.                                   |
| [pinput](https://pub.dev/packages/pinput)                                 | 3.0.1   | A flutter package for custom beautiful pin code fields.                                                                                                            |
| [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator)   | 1.1.0   | A customizable and smooth page indicator for Flutter.                                                                                                              |
| [url_launcher](https://pub.dev/packages/url_launcher)                     | 6.2.2   | A package for launching URLs in native apps.                                                                                                                       |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | 0.13.1  | A package which simplifies the task of updating your Flutter app's launcher icon.                                                                                  |

## 🔗 Resources

-   [Design](<https://www.figma.com/file/lA6Pp8ZQ9XCZeima0laz7Y/Online-Groceries-App-UI-(Community)>)

## 📱 Screenshots

<!-- variables -->

[about]: screenshots/about.jpg 'About'
[account]: screenshots/account.jpg 'Account'
[cart]: screenshots/cart.jpg 'Cart'
[category]: screenshots/category.jpg 'Category'
[explore]: screenshots/explore.jpg 'Explore'
[favorites]: screenshots/favorites.jpg 'Favorites'
[forgot-password]: screenshots/forgot-password.jpg 'Forgot Password'
[help]: screenshots/help.jpg 'Help'
[home]: screenshots/home.jpg 'Home'
[my-details]: screenshots/my-details.jpg 'My Details'
[notifications]: screenshots/notifications.jpg 'Notifications'
[onboarding]: screenshots/onboarding.jpg 'Onboarding'
[order-details]: screenshots/order-details.jpg 'Order Details'
[orders]: screenshots/orders.jpg 'Orders'
[payment-methods]: screenshots/payment-methods.jpg 'Payment Methods'
[product-details]: screenshots/product-details.jpg 'Product Details'
[promo-codes]: screenshots/promo-codes.jpg 'Promo Codes'
[register-phone-dialog]: screenshots/register-phone-dialog.jpg 'Register Phone Dialog'
[register-phone]: screenshots/register-phone.jpg 'Register Phone'
[select-location]: screenshots/select-location.jpg 'Select Location'
[set-location]: screenshots/set-location.jpg 'Set Location'
[signin]: screenshots/signin.jpg 'Sign In'
[signup]: screenshots/signup.jpg 'Sign Up'
[splash]: screenshots/splash.jpg 'Splash'
[store-details]: screenshots/store-details.jpg 'Store Details'
[stores]: screenshots/stores.jpg 'Stores'
[update-location]: screenshots/update-location.jpg 'Update Location'
[verification]: screenshots/verification.jpg 'Verification'

<!-- table of screenshots -->

|      Splash       |        Onboarding         |       Signin       |
| :---------------: | :-----------------------: | :----------------: |
| ![Splash][splash] | ![Onboarding][onboarding] | ![Sign In][signin] |

<!-- signup, forgot, register phone -->

|       Signup       |           Forgot Password           |          Register Phone           |
| :----------------: | :---------------------------------: | :-------------------------------: |
| ![Sign Up][signup] | ![Forgot Password][forgot-password] | ![Register Phone][register-phone] |

|              Register Phone Dialog              |         Verification          |           Select Location           |
| :---------------------------------------------: | :---------------------------: | :---------------------------------: |
| ![Register Phone Dialog][register-phone-dialog] | ![Verification][verification] | ![Select Location][select-location] |

|         Set Location          |     Home      |      Stores       |
| :---------------------------: | :-----------: | :---------------: |
| ![Set Location][set-location] | ![Home][home] | ![Stores][stores] |

|          Store Details          |       Explore       |       Category        |
| :-----------------------------: | :-----------------: | :-------------------: |
| ![Store Details][store-details] | ![Explore][explore] | ![Category][category] |

|           Product Details           |     Cart      |        Favorites        |
| :---------------------------------: | :-----------: | :---------------------: |
| ![Product Details][product-details] | ![Cart][cart] | ![Favorites][favorites] |

|          Order Details          |      Orders       |           Payment Methods           |
| :-----------------------------: | :---------------: | :---------------------------------: |
| ![Order Details][order-details] | ![Orders][orders] | ![Payment Methods][payment-methods] |

|        My Details         |       Account       |          Notifications          |
| :-----------------------: | :-----------------: | :-----------------------------: |
| ![My Details][my-details] | ![Account][account] | ![Notifications][notifications] |

|     Help      |
| :-----------: |
| ![Help][help] |

## 📝 License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

## 👨🏽‍💻 Author(s)

👤 Shokhrukhbek Yuldoshev

-   Github: [@ShokhrukhbekYuldoshev](https://github.com/ShokhrukhbekYuldoshev)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Please ⭐️ this repository if this project helped you!
