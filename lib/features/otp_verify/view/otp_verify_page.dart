import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/features/otp_verify/controller/otp_verify_notifier.dart';
import 'package:flutter_chat/features/otp_verify/ui_state/otp_verify_state.dart';
import 'package:flutter_chat/main.dart';
import 'package:flutter_chat/shared/pods/widgets/otp_custom_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:telephony/telephony.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

@RoutePage()
class VerifyOtpPage extends ConsumerStatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  ConsumerState<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends ConsumerState<VerifyOtpPage> {
  String otp = '';
  Telephony telephony = Telephony.instance;
  late OtpFieldController? otpbox;

  @override
  void initState() {
    super.initState();
     
    // var data = ref.read(otpPod);

    // telephony.listenIncomingSms(
    //   onNewMessage: (SmsMessage message) {
    //     print(message.address);
    //     print(message.body);

    //     String sms = message.body.toString();

    //     if (message.body!.contains('whatsappchat-241bd.firebaseapp.com')) {
    //       String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
    //       otpbox.set(otpcode.split(""));
    //       ref.read(otpVerifyNotifierPod.notifier).otpVerify(otp: otp);

    //     } else {
    //       print("error");
    //     }
    //   },
    //   listenInBackground: false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    // otpbox.set(['1', '2', '3', '4', '5', '6']);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              VxBox(
                      child: [
                "Verification"
                    .text
                    .textStyle(GoogleFonts.lobster())
                    .size(35)
                    .white
                    .make(),
                20.heightBox,
                "We have Send OTP on your register \n Mobile Number"
                    .text
                    .align(TextAlign.center)
                    .white
                    .make()
              ].vStack(
                crossAlignment: CrossAxisAlignment.center,
                alignment: MainAxisAlignment.center,
              ))
                  .height(370)
                  .width(context.screenWidth)
                  .withGradient(
                    const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffea9f43), Color(0xfff2656f)],
                    ),
                  )
                  .make(),
              Expanded(child: VxBox().white.height(370).make()),
            ],
          ),
          OTPTextField(
            outlineBorderRadius: 10,
            controller: otpbox,
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 50,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.box,
            onCompleted: (pin) {
              otp = pin;
            },
          ).positioned(top: 338, left: 10),
          // OtpCustomWidget(
          //   onSubmit: (String value) {
          //     otp = value;
          //     logger.good(value);
          //   },
          // ).positioned(top: 338, left: 10),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (_, WidgetRef ref, __) {
          final loginAsync = ref.watch(otpVerifyNotifierPod);

          return loginAsync.when(
            data: (data) {
              return switch (data) {
                InitialOTPVerifyState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      ref
                          .read(otpVerifyNotifierPod.notifier)
                          .otpVerify(otp: otp);
                      // }
                    },
                    child: 'Send OTP'.text.white.make(),
                  ),
                OtpVerifyLoadingState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {},
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ).h(20).w(20),
                  ),
                OtpVerifySuccessState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {},
                    child: 'Success'.text.white.make(),
                  ),
                OtpVerifyErrorState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {
                      ref
                          .read(otpVerifyNotifierPod.notifier)
                          .otpVerify(otp: otp);
                    },
                    child: 'Error'.text.white.make(),
                  ),
              };
            },
            error: (error, stackTrace) => ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 215, 30, 110))),
              onPressed: () {
                ref.read(otpVerifyNotifierPod.notifier).otpVerify(otp: otp);
              },
              child: 'Error'.text.white.make(),
            ),
            loading: () => ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(255, 215, 30, 110),
                ),
              ),
              onPressed: () {},
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
