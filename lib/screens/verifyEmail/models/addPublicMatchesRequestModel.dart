import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'addPublicMatchesRequestModel.g.dart';

abstract class AddPublicMatchesRequestModel implements Built<AddPublicMatchesRequestModel, AddPublicMatchesRequestModelBuilder> {
  BuiltList<int> get matches;

  AddPublicMatchesRequestModel._();

  factory AddPublicMatchesRequestModel([Function(AddPublicMatchesRequestModelBuilder b) updates]) = _$AddPublicMatchesRequestModel;

  static Serializer<AddPublicMatchesRequestModel> get serializer => _$addPublicMatchesRequestModelSerializer;
}