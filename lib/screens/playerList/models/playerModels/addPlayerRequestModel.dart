import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'addPlayerRequestModel.g.dart';

abstract class AddPlayerRequestModel implements Built<AddPlayerRequestModel, AddPlayerRequestModelBuilder> {
  int? get positionId;
  String get name;
  int? get initialTeamId;

  AddPlayerRequestModel._();

  factory AddPlayerRequestModel([Function(AddPlayerRequestModelBuilder b) updates]) = _$AddPlayerRequestModel;

  static Serializer<AddPlayerRequestModel> get serializer => _$addPlayerRequestModelSerializer;
}