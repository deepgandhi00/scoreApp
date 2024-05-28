import 'package:flutter/material.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/components/textFields/dropDown.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';

class UserTeamDropDown extends StatelessWidget {
  final Function(dynamic) setVal;
  final List<TeamModel> teams;
  final int? currentValue;

  const UserTeamDropDown(
      {Key? key,
      required this.setVal,
      required this.teams,
      required this.currentValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropDown(
      label: 'Select Your Team',
      setValue: setVal,
      options: teams,
      currentValue: currentValue,
      children: getDropDownItems(),
    );
  }

  List<DropdownMenuItem<dynamic>> getDropDownItems() {
    List<DropdownMenuItem<dynamic>> widgetList = [];

    if (teams != null && teams.isNotEmpty) {
      for (int i = 0; i < teams.length; i++) {
        widgetList.add(
          DropdownMenuItem(
            value: teams.elementAt(i).teamId,
            child: Row(
              children: [
                NetworkImageWithPlaceHolder(
                  imageUrl: teams.elementAt(i).logo,
                  width: 24,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  teams.elementAt(i).name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
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
