import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_keeper/utils/colors.dart';

class OtpInput extends StatefulWidget {
  final int numberOfInputs;
  final Function(String otp) callBack;
  final Function editCallBack;
  final String? errorText;

  OtpInput(
      {Key? key,
      this.numberOfInputs = 4,
      required this.callBack,
      required this.editCallBack,
      this.errorText}) {}

  @override
  State<StatefulWidget> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  List<TextEditingController> controllers = [];
  List<String> pin = [];

  @override
  void initState() {
    super.initState();
    pin = List.generate(widget.numberOfInputs, (index) => '');
    controllers = List.generate(
        widget.numberOfInputs, (index) => TextEditingController());
  }

  List<Widget> getInputs(BuildContext context) {
    List<Widget> inputs = [];
    for (int i = 0; i < widget.numberOfInputs; i++) {
      inputs.add(Padding(
        padding: i == 0
            ? const EdgeInsets.fromLTRB(0, 0, 8, 0)
            : const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 64,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(
                  color: CustomColors.inputBorderColor,
                  width: 1,
                  style: BorderStyle.solid)),
          child: TextField(
            textAlign: TextAlign.center,
            controller: controllers[i],
            keyboardType: TextInputType.number,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            decoration: InputDecoration(
              labelText: null,
              filled: true,
              fillColor: CustomColors.appBarColor,
              border: InputBorder.none,
            ),
            onChanged: (String s) {
              pin[i] = s;
              widget.editCallBack();
              if (s.isEmpty) {
                FocusManager.instance.primaryFocus?.previousFocus();
              } else if (!pin.any((element) => element == '')) {
                FocusManager.instance.primaryFocus?.unfocus();
                widget.callBack(pin.join());
              } else {
                FocusManager.instance.primaryFocus?.nextFocus();
              }
            },
          ),
        ),
      ));
    }

    return inputs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: getInputs(context),
        ),
        const SizedBox(
          height: 8,
        ),
        widget.errorText != null
            ? Text(
                widget.errorText!,
                style: TextStyle(color: CustomColors.redText, fontSize: 12),
              )
            : Container(),
      ],
    );
  }
}
