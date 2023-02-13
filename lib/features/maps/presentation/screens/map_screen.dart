import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/routes_manager.dart';
import '../../../phone_auth/presentation/cubit/phone_auth_cubit.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

    return SafeArea(
      child: BlocProvider<PhoneAuthCubit>(
        create: (context) => PhoneAuthCubit(),
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                phoneAuthCubit.signOut();
                Navigator.pushReplacementNamed(context, Routes.phoneAuthRoute);
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0))),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
