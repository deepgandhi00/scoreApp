import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tagsModel.g.dart';

abstract class TagsModel implements Built<TagsModel, TagsModelBuilder>{
  @BuiltValueField(wireName: 'tag_id')
  int? get tagId;

  String get name;

  TagsModel._();

  factory TagsModel([Function(TagsModelBuilder b) updates]) = _$TagsModel;

  static Serializer<TagsModel> get serializer => _$tagsModelSerializer;
}