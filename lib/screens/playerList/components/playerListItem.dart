import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/screens/playerDetails/view/playerDetailsView.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class PlayerListItem extends StatelessWidget {
  final Player? player;
  final bool showAddIcon;
  final bool showRemoveIcon;
  final Function(Player)? onAddPress;
  final Function(BuildContext, Player)? onDeletePress;
  final Function(Player)? onEditPress;
  final Function(Player)? onRemovePress;
  FROM_SCREEN fromScreen;

  PlayerListItem({
    Key? key,
    required this.player,
    this.showAddIcon = false,
    this.showRemoveIcon = false,
    this.onAddPress,
    this.onDeletePress,
    this.onEditPress,
    this.onRemovePress,
    this.fromScreen = FROM_SCREEN.PLAYER_LIST,
  }) : super(key: key);

  Widget getActionButtons(BuildContext context) {
    if (showAddIcon) {
      return GestureDetector(
        onTap: () {
          onAddPress!(player!);
        },
        child: Container(
          height: 27,
          width: 27,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: CustomColors.primaryColor),
          child: const Icon(
            Icons.add,
            size: 15,
            color: Colors.white,
          ),
        ),
      );
    } else if (showRemoveIcon) {
      return GestureDetector(
        onTap: () {
          onRemovePress!(player!);
        },
        child: Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: CustomColors.primaryRed,
          ),
          child: const Icon(
            Icons.remove,
            size: 15,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              onEditPress!(player!);
            },
            child: Image.asset(
              'assets/images/edit_icon.png',
              width: 14,
              height: 17,
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {
              onDeletePress!(context, player!);
            },
            child: Image.asset(
              'assets/images/delete_icon.png',
              width: 14,
              height: 17,
            ),
          ),
        ],
      );
    }
  }

  void onItemPress() {
    if (fromScreen == FROM_SCREEN.PLAYER_LIST) {
      Map<String, String> params = Map();
      params['playerId'] = '${player!.playerId}';
      Get.toNamed(PlayerDetailsView.routeName, parameters: params);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemPress,
      child: Container(
        padding: const EdgeInsets.fromLTRB(13.0, 6.0, 22.0, 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onEditPress != null) {
                        onEditPress!(player!);
                      }
                    },
                    child: NetworkImageWithPlaceHolder(imageUrl: player!.photo),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          player!.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        player!.position ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 24),
                  player!.tagName != null
                      ? Expanded(
                          child: Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColors.tagBackground,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  player!.tagName!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: CustomColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  const SizedBox(width: 24),
                ],
              ),
            ),
            getActionButtons(context),
          ],
        ),
      ),
    );
  }
}
