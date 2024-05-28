import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/utils/colors.dart';

class TagsSuggestionView extends StatelessWidget {
  final List<TagsModel> tags;
  final Function(int tagId)? deleteTag;
  final Function(String tag) onClickTag;

  const TagsSuggestionView({
    Key? key,
    required this.tags,
    this.deleteTag,
    required this.onClickTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        children: getTagItems(),
      ),
    );
  }

  List<Widget> getTagItems() {
    List<Widget> list = [];

    tags.forEach((element) {
      list.add(
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            color: CustomColors.primaryColor,
          ),
          margin: const EdgeInsets.fromLTRB(0, 8, 10, 0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => onClickTag(element.name),
                child: Text(
                  element.name,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const SizedBox(width: 4.0),
              InkWell(
                child: const Icon(
                  Icons.cancel,
                  size: 14.0,
                  color: CustomColors.inputBorderColor,
                ),
                onTap: () {
                  if (deleteTag != null) {
                    deleteTag!(element.tagId!);
                  }
                },
              )
            ],
          ),
        ),
      );
    });

    return list;
  }
}
