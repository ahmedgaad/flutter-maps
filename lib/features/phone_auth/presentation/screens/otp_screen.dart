// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/color_manager.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  late final _phoneNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildIntroOtpTexts(),
              const SizedBox(
                height: 90.0,
              ),
              buildPinCodeFields(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIntroOtpTexts() {
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
                text: 'Enter your 6 digits code numbers sent to',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  height: 1.4,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: _phoneNumber,
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

  Widget buildPinCodeFields(BuildContext context) {
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
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget buildVerifyButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            // if (PhoneAuthCubit.get(context).formKey.currentState!.validate()) {
              
            // }
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
}
