import 'package:flutter/material.dart';
import 'package:nectar/presentation/pages/home/account_page.dart';
import 'package:nectar/presentation/pages/auth/onboarding_page.dart';
import 'package:nectar/presentation/pages/auth/register_phone_page.dart';
import 'package:nectar/presentation/pages/auth/signup_page.dart';
import 'package:nectar/presentation/pages/explore/category_products_pages.dart';
import 'package:nectar/presentation/pages/order/cart_page.dart';
import 'package:nectar/presentation/pages/auth/signin_page.dart';
import 'package:nectar/presentation/pages/explore/explore_page.dart';
import 'package:nectar/presentation/pages/home/favorites_page.dart';
import 'package:nectar/presentation/pages/home/home_page.dart';
import 'package:nectar/presentation/pages/order/order_success_page.dart';
import 'package:nectar/presentation/pages/explore/product_details_page.dart';
import 'package:nectar/presentation/pages/explore/search_page.dart';
import 'package:nectar/presentation/pages/splash_page.dart';

class AppRouter {
  static const String accountRoute = '/account';
  static const String categoryProductsRoute = '/category-products';
  static const String cartRoute = '/cart';
  static const String exploreRoute = '/explore';
  static const String favoritesRoute = '/favorite';
  static const String homeRoute = '/home';
  static const String onboardingRoute = '/onboarding';
  static const String orderSuccessRoute = '/order-success';
  static const String productDetailsRoute = '/product-details';
  static const String registerPhoneRoute = '/register-phone';
  static const String searchRoute = '/search';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String splashRoute = '/splash';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case accountRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const AccountPage(),
        );
      case categoryProductsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const CategoryProductsPage(),
        );
      case cartRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const CartPage(),
        );
      case exploreRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ExplorePage(),
        );
      case favoritesRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const FavoritesPage(),
        );
      case homeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomePage(),
        );
      case onboardingRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OnboardingPage(),
        );
      case orderSuccessRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OrderSuccessPage(),
        );
      case productDetailsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ProductDetailsPage(),
        );
      case registerPhoneRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterPhonePage(),
        );
      case searchRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SearchPage(),
        );
      case signinRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SigninPage(),
        );
      case signupRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SignupPage(),
        );
      case splashRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashPage(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
