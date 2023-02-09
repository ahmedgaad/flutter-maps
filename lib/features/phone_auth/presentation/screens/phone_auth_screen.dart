// ignore_for_file: must_be_immutable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/color_manager.dart';
import '../../../../routes_manager.dart';

class PhoneAuthView extends StatelessWidget {
  PhoneAuthView({super.key});
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  late String phoneNumber;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _phoneFormKey,
            child: Column(
              children: [
                _buildIntroText(),
                const SizedBox(
                  height: 90.0,
                ),
                _buildPhoneAuthFormFiled(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                _buildNextButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }



Widget _buildIntroText() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 55.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "What's your phone number?",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Please Enter your phone number to verify your account.",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPhoneAuthFormFiled() {
  return Padding(
    padding: const EdgeInsets.all(
      15.0,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.lightGrey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  6.0,
                ),
              ),
            ),
            child: Center(
              child: Text(
                '${generateCountryFlag()} +20',
                style: const TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorManager.blue,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter your phone Number!';
                  } else if (value.length < 11) {
                    return 'Phone Number is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

String generateCountryFlag() {
  String countryFlag = 'eg';
  String flag = countryFlag.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
      );
  return flag;
}


Widget _buildNextButton(BuildContext context){
  return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.otpRoute);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 50),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0))),
          child: const Text(
            'Next',
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







