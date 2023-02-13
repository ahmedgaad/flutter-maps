// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/bloc_observer.dart';
import 'package:maps/core/utils/routes_manager.dart';

import 'core/utils/constants_manager.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: AppConstants.apiKey,
            appId: AppConstants.appId,
            messagingSenderId: AppConstants.messagingSenderId,
            projectId: AppConstants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      initialRoute = Routes.splashRoute;
    } else {
      initialRoute = Routes.mapRoute;
    }
  });

  runApp(
    const Maps(),
  );
}

class Maps extends StatelessWidget {
  const Maps({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter().getRoute,
    );
  }
}