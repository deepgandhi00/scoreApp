import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teamModel.g.dart';


abstract class TeamModel implements Built<TeamModel, TeamModelBuilder> {
  int? get teamId;
  String? get logo;
  String get name;

  TeamModel._();

  factory TeamModel([Function(TeamModelBuilder b) updates]) = _$TeamModel;

  static Serializer<TeamModel> get serializer => _$teamModelSerializer;
}