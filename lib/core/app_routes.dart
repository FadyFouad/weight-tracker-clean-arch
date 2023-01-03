import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker_demo/features/auth/presentation/pages/login_page.dart';
import 'package:weight_tracker_demo/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  final FirebaseAuth firebaseAuth;

  static const String home = '/';
  static const String login = '/login';
  late final String initialRoute;

  AppRoutes(this.firebaseAuth) {
    if (firebaseAuth.currentUser == null) {
      initialRoute = login;
    } else {
      initialRoute = home;
    }
  }

  static get routes => {
        home: (context) => HomePage(),
        login: (context) => LoginPage(),
      };
}
