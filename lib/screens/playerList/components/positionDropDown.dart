import 'package:flutter/material.dart';
import 'package:score_keeper/components/textFields/dropDown.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';

class PositionDropDown extends StatelessWidget {
  final int? currentSelectedPosition;
  final List<PositionsModel> positions;
  final Function(dynamic) setVal;

  const PositionDropDown({
    Key? key,
    required this.currentSelectedPosition,
    required this.positions,
    required this.setVal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDown(
      label: 'Position',
      setValue: setVal,
      options: positions,
      currentValue: currentSelectedPosition,
      children: getDropDownItems(),
    );
  }

  List<DropdownMenuItem<dynamic>> getDropDownItems() {
    List<DropdownMenuItem<dynamic>> widgetList = [];

    if (positions.isNotEmpty) {
      for (int i = 0; i < positions.length; i++) {
        widgetList.add(
          DropdownMenuItem(
            value: positions.elementAt(i).position_id,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  positions.elementAt(i).name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        );
      }
    }
    return widgetList;
  }
}
