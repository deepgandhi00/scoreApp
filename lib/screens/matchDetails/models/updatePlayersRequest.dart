import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'updatePlayersRequest.g.dart';

abstract class UpdatePlayersRequest implements Built<UpdatePlayersRequest, UpdatePlayersRequestBuilder> {
  BuiltList<int> get lineups;
  BuiltList<int> get substitutes;

  UpdatePlayersRequest._();

  factory UpdatePlayersRequest([Function(UpdatePlayersRequestBuilder b) updates]) = _$UpdatePlayersRequest;

  static Serializer<UpdatePlayersRequest> get serializer => _$updatePlayersRequestSerializer;
}