import 'package:flutter/material.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';

class DropDown extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(dynamic) setValue;
  final List<dynamic> options;
  final dynamic currentValue;
  final List<DropdownMenuItem<dynamic>> children;

  const DropDown({
    Key? key,
    required this.label,
    this.hintText = StringUtils.PLEASE_ENTER,
    required this.setValue,
    required this.options,
    required this.currentValue,
    this.children = const [],
  }) : super(key: key);

  List<DropdownMenuItem<dynamic>> getItems() {
    if (children.isNotEmpty) {
      return children.toList();
    } else {
      List<DropdownMenuItem<String>> widgets = [];

      for (int i = 0; i < options.length; i++) {
        widgets.add(
          DropdownMenuItem(
            value: options.elementAt(i),
            child: Container(
              child: Text(
                options.elementAt(i),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        );
      }
      return widgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: CustomColors.appBarColor),
      child: FormField<dynamic>(builder: (FormFieldState<dynamic> state) {
        return InputDecorator(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.inputBorderColor),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              menuMaxHeight: MediaQuery.of(context).size.height / 2,
              isDense: true,
              alignment: AlignmentDirectional.centerStart,
              value: currentValue,
              hint: Text(
                hintText,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              items: getItems().toList(),
              onChanged: (dynamic value) {
                setValue(value!);
              },
            ),
          ),
        );
      }),
    );
  }
}
