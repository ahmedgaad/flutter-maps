// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/components_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../cubit/phone_auth_cubit.dart';
import '../cubit/phone_auth_states.dart';

// ignore: must_be_immutable
class OtpView extends StatelessWidget {
  final  phoneNumber;
  late String otpCode;
  OtpView({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildIntroOtpTexts(),
              const SizedBox(
                height: 90.0,
              ),
              _buildPinCodeFields(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              _buildVerifyButton(context),
              _buildPhoneNumberVerifiedBloc(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroOtpTexts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 55.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Verify your phone number?",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
                text: 'Enter your 6 digits code numbers sent to ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  height: 1.4,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: phoneNumber,
                    style: const TextStyle(
                      color: ColorManager.blue,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        obscureText: false,
        autoFocus: true,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor: ColorManager.blue,
            inactiveColor: ColorManager.blue,
            activeFillColor: ColorManager.lightBlue,
            inactiveFillColor: Colors.white,
            selectedColor: ColorManager.blue,
            selectedFillColor: Colors.white),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        onCompleted: (code) {
          otpCode = code;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _login(context);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0))),
          child: const Text(
            'Verify',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberVerifiedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthStates>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, state) {
        if (state is LoadingState) {
          showProgressIndicator(context);
        }
        if (state is PhoneOTPVerified) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(
            Routes.mapRoute,
          );
        }
        if (state is ErrorState) {
          //Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: const TextStyle(color: Colors.black),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      child: Container(),
    );
  }
}
