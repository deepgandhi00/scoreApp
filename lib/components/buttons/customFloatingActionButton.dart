import 'package:flutter/material.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/utils/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function() onPress;
  final Function? onLongPress;
  const CustomFloatingActionButton({Key? key, required this.onPress, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      onLongPress: () {
        if (onLongPress!=null) {
          onLongPress!();
        }
      },
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: CustomColors.primaryColor,
          borderRadius: BorderRadius.circular(26),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
    );
  }
}
