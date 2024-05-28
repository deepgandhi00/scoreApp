
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:built_collection/built_collection.dart';

part 'matchPlayersModel.g.dart';

abstract class MatchPlayersModel implements Built<MatchPlayersModel, MatchPlayersModelBuilder> {
  BuiltList<Player> get data;

  MatchPlayersModel._();

  factory MatchPlayersModel([Function(MatchPlayersModelBuilder b) updates]) = _$MatchPlayersModel;

  static Serializer<MatchPlayersModel> get serializer => _$matchPlayersModelSerializer;
}