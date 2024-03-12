import "package:flutter/material.dart";
import "package:nectar/src/presentation/pages/splash_page.dart";
import "package:nectar/src/presentation/utils/app_colors.dart";
import "package:nectar/src/presentation/utils/app_router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nectar',
      debugShowCheckedModeBanner: false,
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
