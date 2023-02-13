import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/maps/presentation/screens/map_screen.dart';
import '../../features/phone_auth/presentation/cubit/phone_auth_cubit.dart';
import '../../features/phone_auth/presentation/screens/otp_screen.dart';
import '../../features/phone_auth/presentation/screens/phone_auth_screen.dart';
import '../../features/phone_auth/presentation/screens/splash_screen.dart';

class Routes {
  static const String splashRoute = "/splashScreen";
  static const String phoneAuthRoute = "/phoneAuthScreen";
  static const String otpRoute = "/otpScreen";
  static const String mapRoute = "/mapScreen";
}

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.phoneAuthRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: PhoneAuthView(),
          ),
        );
      case Routes.otpRoute:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpView(phoneNumber : phoneNumber),
          ),
        );
      case Routes.mapRoute:
        return MaterialPageRoute(builder: (_) => const MapView());
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
