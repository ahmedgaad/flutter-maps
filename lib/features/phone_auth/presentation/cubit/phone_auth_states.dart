abstract class PhoneAuthStates {}

class PhoneAuthInitial extends PhoneAuthStates {}

class LoadingState extends PhoneAuthStates {}

class ErrorState extends PhoneAuthStates {
  final String error;
  ErrorState(this.error);
}

class PhoneNumberSubmited extends PhoneAuthStates {}

class PhoneOTPVerified extends PhoneAuthStates {}
