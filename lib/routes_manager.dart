import 'package:flutter/material.dart';
import 'package:maps/features/phone_auth/presentation/screens/otp_screen.dart';
import 'features/phone_auth/presentation/screens/phone_auth_screen.dart';
import 'features/phone_auth/presentation/screens/splash_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String phoneAuthRoute = "/phoneAuth";
  static const String otpRoute = "/otpRoute";
  static const String mapRoute = "/map";
}

class AppRouter {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.phoneAuthRoute:
        return MaterialPageRoute(builder: (_) => PhoneAuthView());
      case Routes.mapRoute:
        return MaterialPageRoute(builder: (_) => SizedBox());
      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) => OtpView());
      default:
        return unDefinedRoute();
    } //switch
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text(
            'noRoute Found',
          ),
        ),
      ),
    );
  }
}
