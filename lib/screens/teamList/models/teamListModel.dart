import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:built_collection/built_collection.dart';

part 'teamListModel.g.dart';

abstract class TeamListModel implements Built<TeamListModel, TeamListModelBuilder>{
  BuiltList<TeamModel> get data;

  TeamListModel._();

  factory TeamListModel([Function(TeamListModelBuilder b) updates]) = _$TeamListModel;

  static Serializer<TeamListModel> get serializer => _$teamListModelSerializer;
}