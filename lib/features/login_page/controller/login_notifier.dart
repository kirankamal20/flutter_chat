import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/data/service/login/login_service_pod.dart';
import 'package:flutter_chat/features/login_page/controller/verification_code_pod.dart';
import 'package:flutter_chat/features/login_page/ui_state/otp_state.dart';
import 'package:flutter_chat/router/auto_router_pod.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<OtpState> {
  @override
  build() {
    return InitialOTPState();
  }

  void sendOtp({required String mobileNumber}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // state = await AsyncValue.guard(() async {
    state = AsyncData(InProgressOTPState());
    try {
      await ref.watch(loginPod).sendOTP(
            verificationCompleted: (phoneAuthCredential) {
              print("ddfdfdfdfdf");
              auth.signInWithCredential(phoneAuthCredential);
            },
            verificationFailed: (errorMessage) {
              state = AsyncValue.data(
                  ErrorOTPState(errorMessage.message.toString()));
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              ref
                  .read(verificationCodePod.notifier)
                  .update((state) => verificationId);
              ref.read(autrouterPod).navigate(const VerifyOtpRoute());
              state = AsyncValue.data(CompletedOTPState());
            },
            codeAutoRetrievalTimeout: (p0) {},
            phoneNumber: mobileNumber,
          );

      // return CompletedOTPState();
      // });
    } catch (e) {
      state = AsyncValue.data(ErrorOTPState("erorr"));
    }
  }
}

final loginNotifierPod =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, OtpState>(
  () => LoginNotifier(),
);
