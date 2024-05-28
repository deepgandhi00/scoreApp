import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'addTagsModel.g.dart';

abstract class AddTagsModel implements Built<AddTagsModel, AddTagsModelBuilder> {
  BuiltList<String> get tags;

  AddTagsModel._();

  factory AddTagsModel([Function(AddTagsModelBuilder b) updates]) = _$AddTagsModel;

  static Serializer<AddTagsModel> get serializer => _$addTagsModelSerializer;
}