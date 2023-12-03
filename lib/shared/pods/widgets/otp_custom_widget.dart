import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

typedef OnCodeEnteredCompletion = void Function(String value);

class OtpCustomWidget extends StatefulWidget {
  final OnCodeEnteredCompletion? onSubmit;
  const OtpCustomWidget({super.key, required this.onSubmit});

  @override
  State<OtpCustomWidget> createState() => _OtpCustomWidgetState();
}

class _OtpCustomWidgetState extends State<OtpCustomWidget> {
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;
  late List<String?> _verificationCode;
  @override
  void initState() {
    super.initState();
    _verificationCode = List<String?>.filled(6, null);
    _focusNodes = List<FocusNode?>.filled(6, null);
    _textControllers = List<TextEditingController?>.filled(
      6,
      null,
    );
  }

  void addFocusNodeToEachTextField({required int index}) {
    if (_focusNodes[index] == null) {
      _focusNodes[index] = FocusNode();
    }
  }

  void addTextEditingControllerToEachTextField({required int index}) {
    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();
    }
  }

  void changeFocusToNextNodeWhenValueIsEntered({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      //if the textField in focus is not the last textField,
      // change focus to the next textField
      if (indexOfTextField + 1 != 6) {
        //change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        //if the textField in focus is the last textField, unFocus after text changed
        _focusNodes[indexOfTextField]?.unfocus();
      }
    }
  }

  void changeFocusToPreviousNodeWhenValueIsRemoved({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the previous textField if the value entered has a length zero
    if (value.isEmpty) {
      //if the textField in focus is not the first textField,
      // change focus to the previous textField
      if (indexOfTextField != 0) {
        //change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField - 1]);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _textControllers) {
      controller?.dispose();
    }
  }

  Widget buildTextField({required int index}) {
    return VxBox(
      child: TextField(
        textAlign: TextAlign.center,
        showCursor: false,
        keyboardType: TextInputType.number,
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        onChanged: (value) {
          _verificationCode[index] = value;
          print("verification code : ${_verificationCode.join()}");
          changeFocusToNextNodeWhenValueIsEntered(
            value: value,
            indexOfTextField: index,
          );
          changeFocusToPreviousNodeWhenValueIsRemoved(
              value: value, indexOfTextField: index);
          onSubmit(verificationCode: _verificationCode);
        },
        decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ).centered(),
    ).height(50).width(40).white.make().card.make().p(4);
  }

  void onSubmit({required List<String?> verificationCode}) {
    if (verificationCode.every((String? code) => code != null && code != '')) {
      if (widget.onSubmit != null) {
        widget.onSubmit!(verificationCode.join());
      }
    }
  }

  List<Widget> generateTextFields() {
    List<Widget> textfields = List.generate(6, (i) {
      addFocusNodeToEachTextField(index: i);
      addTextEditingControllerToEachTextField(index: i);
      return buildTextField(index: i);
    });

    return textfields;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: generateTextFields(),
    );
  }
}
