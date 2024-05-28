import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'addPlayerToTeamRequestModel.g.dart';

abstract class AddPlayerToTeamRequestModel implements Built<AddPlayerToTeamRequestModel, AddPlayerToTeamRequestModelBuilder> {
  BuiltList<int> get players;

  AddPlayerToTeamRequestModel._();

  factory AddPlayerToTeamRequestModel([Function(AddPlayerToTeamRequestModelBuilder b) updates]) = _$AddPlayerToTeamRequestModel;

  static Serializer<AddPlayerToTeamRequestModel> get serializer => _$addPlayerToTeamRequestModelSerializer;
}