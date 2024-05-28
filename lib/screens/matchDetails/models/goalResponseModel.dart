import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:built_collection/built_collection.dart';

part 'goalResponseModel.g.dart';

abstract class GoalResponseModel implements Built<GoalResponseModel, GoalResponseModelBuilder> {
  GoalModel get data;

  GoalResponseModel._();

  factory GoalResponseModel([Function(GoalResponseModelBuilder b) updates]) = _$GoalResponseModel;

  static Serializer<GoalResponseModel> get serializer => _$goalResponseModelSerializer;
}