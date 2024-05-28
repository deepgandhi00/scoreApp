import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:built_collection/built_collection.dart';

part 'tagsListModel.g.dart';

abstract class TagsListModel implements Built<TagsListModel, TagsListModelBuilder> {
  BuiltList<TagsModel> get data;

  TagsListModel._();

  factory TagsListModel([Function(TagsListModelBuilder b) updates]) = _$TagsListModel;

  static Serializer<TagsListModel> get serializer => _$tagsListModelSerializer;
}