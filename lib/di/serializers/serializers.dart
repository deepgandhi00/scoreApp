import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/models/notificationMatchModel.dart';
import 'package:score_keeper/models/responseErrorModel.dart';
import 'package:score_keeper/models/tagsListModel.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/enterEmail/models/generateOtpRequestModel.dart';
import 'package:score_keeper/screens/home/models/userModel.dart';
import 'package:score_keeper/screens/matchDetails/models/addGoalModel.dart';
import 'package:score_keeper/screens/matchDetails/models/goalModel.dart';
import 'package:score_keeper/screens/matchDetails/models/goalResponseModel.dart';
import 'package:score_keeper/screens/matchDetails/models/matchPlayersModel.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeListModel.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeModel.dart';
import 'package:score_keeper/screens/matchDetails/models/updatePlayersRequest.dart';
import 'package:score_keeper/screens/matchDetails/models/updateStatusModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/playerDetails/models/playerDetailModel.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/addPlayerRequestModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/playerListModel.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsListModel.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsModel.dart';
import 'package:score_keeper/screens/profile/models/logoutRequestModel.dart';
import 'package:score_keeper/screens/teamList/models/teamListModel.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/screens/teamPlayerList/models/addPlayerToTeamRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/addPublicMatchesRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpResponseModel.dart';
import 'package:built_collection/built_collection.dart';

import '../../screens/matchesTabs/models/matchListModel.dart';

part 'serializers.g.dart';

@SerializersFor([
  GenerateOtpRequestModel,
  Player,
  TeamListModel,
  TeamModel,
  VerifyOtpResponseModel,
  VerifyOtpRequestModel,
  ResponseErrorModel,
  MatchListModel,
  MatchModel,
  Player,
  PlayerListModel,
  PositionsModel,
  PositionsListModel,
  AddPlayerRequestModel,
  ResponseErrorModel,
  AddPlayerToTeamRequestModel,
  PlayerDetailModel,
  MatchPlayersModel,
  MatchStatusEnum,
  UpdatePlayersRequest,
  UpdateStatusModel,
  GoalModel,
  AddGoalModel,
  ScoreTypeModel,
  ScoreTypeListModel,
  GoalResponseModel,
  UserModel,
  AddPublicMatchesRequestModel,
  NotificationMatchModel,
  TagsModel,
  TagsListModel,
  AddTagsModel,
  LogoutRequestModel,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
