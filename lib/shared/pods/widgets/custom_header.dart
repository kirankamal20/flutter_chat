import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight,
      child: Stack(
        children: [
          Positioned(
            left: -100,
            top: -50,
            child: VxBox()
                .height(350)
                .width(350)
                .withGradient(
                  const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 146, 11, 70),
                      Color.fromARGB(255, 224, 59, 131),
                    ],
                  ),
                )
                .roundedFull
                .make(),
          ),
          Positioned(
            right: -50,
            top: -140,
            child: VxBox()
                .height(350)
                .width(350)
                .withGradient(
                  const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xffaf1658),
                      Color.fromARGB(255, 151, 10, 71),
                    ],
                  ),
                )
                .roundedFull
                .make(),
          ),
          // Positioned(
          //   child: "Register".text.size(30).white.make(),
          // ),
          // 50.heightBox,
          Align(
            alignment: Alignment.center,
            child: child,
          ),
        ],
      ),
    );
  }
}
