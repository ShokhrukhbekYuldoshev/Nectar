import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nectar/bloc/account/account_bloc.dart';
import 'package:nectar/bloc/favorites/favorites_bloc.dart';
import 'package:nectar/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:nectar/bloc/login/login_bloc.dart';
import 'package:nectar/bloc/product/product_bloc.dart';
import 'package:nectar/bloc/register/register_bloc.dart';
import 'package:nectar/bloc/register_phone/register_phone_bloc.dart';
import 'package:nectar/bloc/shop/shop_bloc.dart';
import 'package:nectar/data/repositories/product_repository.dart';
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
