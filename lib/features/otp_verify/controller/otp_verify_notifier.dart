import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/features/login_page/controller/verification_code_pod.dart';
import 'package:flutter_chat/features/otp_verify/ui_state/otp_verify_state.dart';
import 'package:flutter_chat/router/auto_router_pod.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telephony/telephony.dart';

class OtpVerifyNotifier extends AutoDisposeAsyncNotifier<OtpVerifyState> {
  @override
  build() {
    readOtpMessage();
    return InitialOTPVerifyState();
  }

  void otpVerify({required String otp}) async {
    // state = await AsyncValue.guard(() async {
    state = AsyncData(OtpVerifyLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: ref.read(verificationCodePod),
        smsCode: otp,
      ));
      final result = await ref.watch(authStateChangesProvider.future);
      if (result != null) {
        ref.read(autrouterPod).navigate(const HomeRoute());
        state = AsyncData(OtpVerifySuccessState());
      } else {
        state = AsyncValue.data(OtpVerifyErrorState("error"));
      }
    } catch (e) {
      state = AsyncValue.data(OtpVerifyErrorState("error"));
    }
  }

  void readOtpMessage() {
    Telephony telephony = Telephony.instance;
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);

        String sms = message.body.toString();

        if (message.body!.contains('whatsappchat-241bd.firebaseapp.com')) {
          String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
          var d = otpcode.split("");
          ref.read(otpPod.notifier).update((state) => d);
          // otpbox.set(otpcode.split(""));
          otpVerify(otp: otpcode);
        } else {
          print("error");
        }
      },
      listenInBackground: false,
    );
  }
}

final otpVerifyNotifierPod =
    AutoDisposeAsyncNotifierProvider<OtpVerifyNotifier, OtpVerifyState>(
  () => OtpVerifyNotifier(),
);

final otpPod = StateProvider<List<String>>((ref) {
  return  [];
});
