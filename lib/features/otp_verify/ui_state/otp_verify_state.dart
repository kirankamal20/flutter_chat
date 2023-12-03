sealed class OtpVerifyState {
  OtpVerifyState();
}

class InitialOTPVerifyState extends OtpVerifyState {
  InitialOTPVerifyState();
}

class OtpVerifyLoadingState extends OtpVerifyState {
  OtpVerifyLoadingState();
}

class OtpVerifySuccessState extends OtpVerifyState {
  OtpVerifySuccessState();
}

class OtpVerifyErrorState extends OtpVerifyState {
  final String errorMessage;

  OtpVerifyErrorState(this.errorMessage);
}
