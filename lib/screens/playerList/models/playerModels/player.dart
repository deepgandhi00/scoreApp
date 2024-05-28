import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'player.g.dart';

abstract class Player implements Built<Player, PlayerBuilder> {
  String get name;
  String? get position;
  int get playerId;
  int? get positionId;
  String? get type;
  String? get photo;
  String? get tagName;

  Player._();

  factory Player([Function(PlayerBuilder b) updates]) = _$Player;

  static Serializer<Player> get serializer => _$playerSerializer;
}