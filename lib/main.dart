import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nectar/firebase_options.dart';
import 'package:nectar/src/app.dart';
import 'package:nectar/src/bloc/account/account_bloc.dart';
import 'package:nectar/src/bloc/category_products/category_products_bloc.dart';
import 'package:nectar/src/bloc/explore/explore_bloc.dart';
import 'package:nectar/src/bloc/favorites/favorites_bloc.dart';
import 'package:nectar/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:nectar/src/bloc/login/login_bloc.dart';
import 'package:nectar/src/bloc/product/product_bloc.dart';
import 'package:nectar/src/bloc/register/register_bloc.dart';
import 'package:nectar/src/bloc/register_phone/register_phone_bloc.dart';
import 'package:nectar/src/bloc/search/search_bloc.dart';
import 'package:nectar/src/bloc/shop/shop_bloc.dart';
import 'package:nectar/src/bloc/store_details/store_details_bloc.dart';
import 'package:nectar/src/bloc/stores/stores_bloc.dart';
import 'package:nectar/src/data/repositories/product_repository.dart';
import 'package:nectar/src/data/services/hive_adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Hive.initFlutter();
  registerAdapters();
  await Hive.openBox('myBox');
  ProductRepository.loadCart();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterPhoneBloc(),
        ),
        BlocProvider(
          create: (context) => AccountBloc(),
        ),
        BlocProvider(
          create: (context) => ShopBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
        BlocProvider(
          create: (context) => ExploreBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryProductsBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => StoreDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => StoresBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
