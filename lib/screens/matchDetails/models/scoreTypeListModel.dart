import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';

part 'scoreTypeListModel.g.dart';

abstract class ScoreTypeListModel implements Built<ScoreTypeListModel, ScoreTypeListModelBuilder> {
  BuiltList<ScoreTypeModel> get scoreTypes;

  ScoreTypeListModel._();

  factory ScoreTypeListModel([Function(ScoreTypeListModelBuilder b) updates]) = _$ScoreTypeListModel;

  static Serializer<ScoreTypeListModel> get serializer => _$scoreTypeListModelSerializer;
}