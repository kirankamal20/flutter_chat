import 'package:auto_route/annotations.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/features/login_page/controller/login_notifier.dart';
import 'package:flutter_chat/features/login_page/ui_state/otp_state.dart';
import 'package:flutter_chat/router/auto_router_pod.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:flutter_chat/shared/pods/widgets/custom_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String mobileNumber = "";
  final otpTextControlller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {

    super.initState();
  }

  void _triggerError() {
     
    int result = 5 ~/ 0;  
    print(result); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      body: CustomHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            " Verifty your \n Phone Number"
                .text
                .size(30)
                .make()
                .objectCenterLeft()
                .p(10),
            IntlPhoneField(
              controller: otpTextControlller,
              initialCountryCode: '+92',
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              languageCode: "en",
              onChanged: (phone) {
                mobileNumber = phone.completeNumber;
                print(phone.completeNumber);
              },
              onCountryChanged: (country) {
                print('Country changed to: ${country.name}');
              },
            ).p(14),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer(
        builder: (_, WidgetRef ref, __) {
          final loginAsync = ref.watch(loginNotifierPod);

          return loginAsync.when(
            data: (data) {
              return switch (data) {
                InitialOTPState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      ref
                          .read(loginNotifierPod.notifier)
                          .sendOtp(mobileNumber: mobileNumber);
                      // }
                    },
                    child: 'Send OTP'.text.white.make(),
                  ),
                InProgressOTPState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {},
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ).h(20).w(20),
                  ),
                CompletedOTPState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {},
                    child: 'Success'.text.white.make(),
                  ),
                ErrorOTPState() => ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 215, 30, 110))),
                    onPressed: () {
                      ref
                          .read(loginNotifierPod.notifier)
                          .sendOtp(mobileNumber: mobileNumber);
                    },
                    child: 'Error'.text.white.make(),
                  ),
              };
            },
            error: (error, stackTrace) => ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 215, 30, 110))),
              onPressed: () {},
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
      ).w(300),
    );
  }
}
