sealed class OtpState {
  OtpState();
}

class InitialOTPState extends OtpState {
  InitialOTPState();
}

class InProgressOTPState extends OtpState {
  InProgressOTPState();
}

class CompletedOTPState extends OtpState {
  CompletedOTPState();
}

class ErrorOTPState extends OtpState {
  final String errorMessage;

  ErrorOTPState(this.errorMessage);
}
