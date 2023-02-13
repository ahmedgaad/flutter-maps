// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/features/phone_auth/presentation/cubit/phone_auth_states.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthStates> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  late String verificationId;
  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  Future<void> submitPhoneNumber(String phoneNumber,) async {
    emit(LoadingState());

    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20 $phoneNumber',
      timeout: const Duration(seconds: 16),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verification completed");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print("verificationFailed ${error.toString()}");
    emit(ErrorState(error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print("codeSent");
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print("codeAutoRetrievalTimeout");
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
    // return FirebaseAuth.instance.currentUser!;
  }
}
