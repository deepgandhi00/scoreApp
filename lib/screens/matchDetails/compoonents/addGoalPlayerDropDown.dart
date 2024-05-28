import 'package:flutter/material.dart';
import 'package:score_keeper/components/textFields/dropDown.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';

class AddGoalPlayerDropDown extends StatelessWidget {
  final List<Player> players;
  final Function(dynamic) setValue;
  final int? currentValue;
  final String label;
  final String hintText;

  const AddGoalPlayerDropDown({
    Key? key,
    required this.players,
    required this.currentValue,
    required this.setValue,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDown(
      label: label,
      setValue: setValue,
      options: players,
      currentValue: currentValue,
      children: getDropDownItems(),
      hintText: hintText,
    );
  }

  List<DropdownMenuItem<dynamic>> getDropDownItems() {
    List<DropdownMenuItem<dynamic>> widgetList = [];
    for (int i = 0; i < players.length; i++) {
      widgetList.add(
        DropdownMenuItem(
          value: players.elementAt(i).playerId,
          child: Text(
            players.elementAt(i).name,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return widgetList;
  }
}
