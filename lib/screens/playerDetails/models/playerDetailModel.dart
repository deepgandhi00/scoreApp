import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:built_collection/built_collection.dart';

part 'playerDetailModel.g.dart';

abstract class PlayerDetailModel implements Built<PlayerDetailModel, PlayerDetailModelBuilder> {
  int get playerId;
  String get name;
  int? get positionId;
  String? get position;
  BuiltList<TeamModel> get teams;
  int get matchesCount;
  int get goalsCount;
  int get assistsCount;
  String? get photo;
  String? get tagName;

  PlayerDetailModel._();

  factory PlayerDetailModel([Function(PlayerDetailModelBuilder b) updates]) = _$PlayerDetailModel;

  static Serializer<PlayerDetailModel> get serializer => _$playerDetailModelSerializer;
}