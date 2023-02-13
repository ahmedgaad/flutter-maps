// ignore_for_file: must_be_immutable, prefer_final_fields, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/core/utils/components_manager.dart';
import 'package:maps/features/phone_auth/presentation/cubit/phone_auth_cubit.dart';
import 'package:maps/features/phone_auth/presentation/cubit/phone_auth_states.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';

class PhoneAuthView extends StatelessWidget {
  PhoneAuthView({super.key});
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  late String phoneNumber;
  //TextEditingController phoneController = TextEditingController();

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
                _buildPhoneNumberSubmitedBloc(),
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
                  generateCountryFlag() + ' +20',
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
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context)
          .submitPhoneNumber(phoneNumber);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            showProgressIndicator(context);
            _register(context);
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

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthStates>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, state) {
        if (state is LoadingState) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.of(context).pop();
          Navigator.of(context)
              .pushNamed(Routes.otpRoute, arguments: phoneNumber);
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
