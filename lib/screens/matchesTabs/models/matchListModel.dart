import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';

part 'matchListModel.g.dart';

abstract class MatchListModel implements Built<MatchListModel, MatchListModelBuilder> {
  BuiltList<MatchModel> get data;

  MatchListModel._();

  factory MatchListModel([Function(MatchListModelBuilder b) updates]) = _$MatchListModel;

  static Serializer<MatchListModel> get serializer => _$matchListModelSerializer;
}