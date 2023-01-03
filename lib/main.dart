import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/app_routes.dart';
import 'package:weight_tracker_demo/core/app_theme.dart';
import 'package:weight_tracker_demo/core/firebase_initializer.dart';
import 'package:weight_tracker_demo/core/injection.dart';
import 'package:weight_tracker_demo/core/navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  await Injection.setup();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: CustomNavigator.key,
        builder: (context, child) {
          return SafeArea(child: child!);
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
        ],
        initialRoute: Injection.getIt.get<AppRoutes>().initialRoute,
        locale: const Locale('en'),
        routes: AppRoutes.routes,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
