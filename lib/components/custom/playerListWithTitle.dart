import 'package:flutter/material.dart';
import 'package:score_keeper/screens/playerList/components/playerListItem.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class PlayerListWithTitle extends StatelessWidget {
  List<Player>? players;
  final String title;
  final bool isLineUp;
  final Function(Player)? onAddPress;
  final Function(Player)? onRemovePress;
  bool showDone;
  Function()? onDonePress;
  bool showAdd;
  Function()? onAddIconPress;

  PlayerListWithTitle({
    Key? key,
    this.players,
    required this.title,
    required this.isLineUp,
    this.onAddPress,
    this.onRemovePress,
    this.showDone = false,
    this.onDonePress,
    this.showAdd = false,
    this.onAddIconPress,
  }) : super(key: key);

  List<Widget> getItems(bool isLineUp) {
    List<Widget> list = [];
    for (int i = 0; i < players!.length; i++) {
      list.add(
        Column(
          children: [
            PlayerListItem(
              player: players!.isNotEmpty ? players!.elementAt(i) : null,
              showAddIcon: !isLineUp,
              showRemoveIcon: isLineUp,
              onAddPress: onAddPress,
              onRemovePress: onRemovePress,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            ),
          ],
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (players != null && players!.isNotEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            showAdd
                ? IconButton(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    visualDensity: VisualDensity.comfortable,
                    onPressed: onAddIconPress,
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: CustomColors.primaryColor,
                      size: 22,
                    ))
                : Container(),
            showDone
                ? IconButton(
                    onPressed: onDonePress,
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    visualDensity: VisualDensity.comfortable,
                    icon: const Icon(
                      Icons.check_rounded,
                      color: CustomColors.primaryColor,
                      size: 22,
                    ),
                  )
                : Container(),
          ],
        ),
        showDone
            ? const Text(
                'Click ✅ to save',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12, color: Colors.white,),
              )
            : Container(),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: CustomColors.appBarColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: getItems(isLineUp),
          ),
        ),
      ]);
    } else {
      return Container();
    }
  }
}
