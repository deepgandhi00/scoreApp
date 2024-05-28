import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'userModel.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  int get user_id;
  String get email;
  String? get photo;

  UserModel._();

  factory UserModel([Function(UserModelBuilder b) updates]) = _$UserModel;

  static Serializer<UserModel> get serializer => _$userModelSerializer;
}