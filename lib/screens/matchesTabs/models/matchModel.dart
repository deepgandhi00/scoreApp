import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:built_collection/built_collection.dart';
import 'package:score_keeper/utils/utils.dart';

part 'matchModel.g.dart';

abstract class MatchModel implements Built<MatchModel, MatchModelBuilder> {
  int get matchId;
  int get primaryTeamId;
  String get primaryTeamName;
  String? get primaryTeamLogo;
  String get secondaryTeamName;
  String? get secondaryTeamLogo;
  String? get location;
  String get date;
  MatchStatusEnum get status;
  int get primaryTeamGoals;
  int get secondaryTeamGoals;
  int? get timer;
  MatchStatusEnum? get progress;
  BuiltList<Player> get players;
  BuiltList<GoalModel> get goals;
  int? get isPublic;
  bool? get owner;
  String? get kickOffTime;
  String? get league;

  MatchModel._();

  factory MatchModel([Function(MatchModelBuilder b) updates]) = _$MatchModel;

  static Serializer<MatchModel> get serializer => _$matchModelSerializer;
}