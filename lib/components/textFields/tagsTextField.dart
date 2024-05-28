import 'package:flutter/material.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/stringUtils.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagsTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextfieldTagsController textFieldTagsController;
  final List<String> initialTags;

  const TagsTextField({
    Key? key,
    required this.textEditingController,
    required this.textFieldTagsController,
    required this.initialTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      textEditingController: textEditingController,
      textfieldTagsController: textFieldTagsController,
      initialTags: initialTags,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (textFieldTagsController.getTags != null &&
            textFieldTagsController.getTags!.contains(tag)) {
          return StringUtils.TAG_ALREADY_ENTERED;
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return TextField(
            controller: tec,
            focusNode: fn,
            scrollPadding: const EdgeInsets.only(bottom: 128),
            decoration: InputDecoration(
              hintText: textFieldTagsController.hasTags ? '' : StringUtils.ENTER_TAGS,
              errorText: error,
              prefixIconConstraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.74),
              prefixIcon: tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: sc,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: tags.map((String tag) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: CustomColors.primaryColor,
                          ),
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  tag,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  //print("$tag selected");
                                },
                              ),
                              const SizedBox(width: 4.0),
                              InkWell(
                                child: const Icon(
                                  Icons.cancel,
                                  size: 14.0,
                                  color: CustomColors.inputBorderColor,
                                ),
                                onTap: () {
                                  onTagDelete(tag);
                                },
                              )
                            ],
                          ),
                        );
                      }).toList()),
                    )
                  : null,
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          );
        });
      },
    );
  }
}
