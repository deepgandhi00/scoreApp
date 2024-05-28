import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notificationMatchModel.g.dart';

abstract class NotificationMatchModel implements Built<NotificationMatchModel, NotificationMatchModelBuilder>{
  String get date;
  String get primaryTeamName;
  String get secondaryGoalCount;
  String get secondaryTeamName;
  String get timer;
  String? get mins;
  String? get progress;
  String? get matchId;
  String? get status;
  String? get secondaryTeamLogo;
  String? get primaryTeamLogo;
  String? get primaryGoalCount;
  String? get assistPlayerName;
  String? get playerName;
  String? get scoreType;
  String? get isSecondaryTeam;

  NotificationMatchModel._();

  factory NotificationMatchModel([Function(NotificationMatchModelBuilder b) updates]) = _$NotificationMatchModel;

  static Serializer<NotificationMatchModel> get serializer => _$notificationMatchModelSerializer;
}