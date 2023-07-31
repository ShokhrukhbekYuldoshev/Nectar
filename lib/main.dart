import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nectar/bloc/account/account_bloc.dart';
import 'package:nectar/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:nectar/bloc/login/login_bloc.dart';
import 'package:nectar/bloc/product/product_bloc.dart';
import 'package:nectar/bloc/register/register_bloc.dart';
import 'package:nectar/bloc/register_phone/register_phone_bloc.dart';
import 'package:nectar/bloc/shop/shop_bloc.dart';
import 'package:nectar/data/enums/unit.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';
import 'package:nectar/data/services/hive_adapters.dart';
import 'package:nectar/firebase_options.dart';
import 'package:nectar/presentation/pages/splash_page.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  registerAdapters();
  await Hive.openBox('myBox');

  // grocery
  Product product = Product(
    name: 'Potato',
    store: await FirebaseFirestoreService()
        .getDocumentReference('stores', 'name', 'D-Mart'),
    description: null,
    price: 10.0,
    unit: Unit.kg,
    images: null,
    category: null,
    brand: 'Yummy',
    nutritions: const {'protein': 10.0, 'fat': 10.0},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  Store store = Store(
    name: 'Downtown Supermarket',
    description: null,
    image: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    latitude: 0.00,
    longitude: 0.00,
  );

  // await FirebaseFirestoreService().addDocument(
  //   'products',
  //   product.toMap(),
  // );

  // await FirebaseFirestoreService().addDocument(
  //   'stores',
  //   store.toMap(),
  // );

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all<Color>(
            AppColors.primary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: const SplashPage(),
    );
  }
}
