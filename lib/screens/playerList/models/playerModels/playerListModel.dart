import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';

part 'playerListModel.g.dart';

abstract class PlayerListModel implements Built<PlayerListModel, PlayerListModelBuilder> {
  BuiltList<Player> get data;

  PlayerListModel._();

  factory PlayerListModel([Function(PlayerListModelBuilder b) updates]) = _$PlayerListModel;

  static Serializer<PlayerListModel> get serializer => _$playerListModelSerializer;
}