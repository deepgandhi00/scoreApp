import 'dart:io';
import 'package:http/io_client.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/converters/builtValueConverter.dart';
import 'package:score_keeper/di/services/interceptors/CustomResponseInterceptor.dart';
import 'package:score_keeper/di/services/interceptors/requestInterceptor.dart';
import 'package:score_keeper/models/matchStatusEnum.dart';
import 'package:score_keeper/screens/matchDetails/models/addGoalModel.dart';
import 'package:score_keeper/screens/matchDetails/models/matchPlayersModel.dart';
import 'package:score_keeper/screens/matchDetails/models/scoreTypeListModel.dart';
import 'package:score_keeper/screens/matchDetails/models/updatePlayersRequest.dart';
import 'package:score_keeper/screens/matchDetails/models/updateStatusModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchListModel.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/addPublicMatchesRequestModel.dart';
import 'package:score_keeper/utils/stringUtils.dart';

part 'matchService.chopper.dart';

@ChopperApi(baseUrl: '/api/match')
abstract class MatchService extends ChopperService {
  static MatchService create([ChopperClient? client]) {
    final client = ChopperClient(
        baseUrl: Uri.http(StringUtils.BASE_URL_STAGING),
        services: [],
        converter: BuiltValueConverter(),
        client: http.IOClient(
          HttpClient()..connectionTimeout = const Duration(seconds: 8),
        ),
        errorConverter: BuiltValueConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          CustomRequestInterceptor(),
          CustomResponseInterceptor()
        ]);

    return _$MatchService(client);
  }

  @Get(path: '/list')
  Future<Response<MatchListModel>> getMatches();

  @Post(path: '/create', headers: {'Content-Type': 'multipart/form-data'})
  @Multipart()
  Future<Response<void>> createMatch(
    @Part() int primaryTeamId,
    @Part() String secondaryTeamName,
    @Part() String location,
    @Part() String league,
    @Part() String date,
    @Part() String lineups,
    @Part() String substitutes,
    @Part() int isPublic,
    @Part() String? kickOffTime,
    @PartFile() String? file,
  );

  @Get(path: '{matchId}')
  Future<Response<MatchModel>> getMatchSummery(@Path('matchId') int matchId);

  @Get(path: '{matchId}/players')
  Future<Response<MatchPlayersModel>> getMatchPlayers(
      @Path('matchId') int matchId);

  @Put(path: '{matchId}/players')
  Future<Response<void>> editPlayersOfMatch(@Path('matchId') int matchId,
      @Body() UpdatePlayersRequest updatePlayersRequest);

  @Put(path: '{matchId}/status/{status}')
  Future<Response<MatchModel>> updateMatchStatus(
      @Path('matchId') int matchId,
      @Path('status') MatchStatusEnum matchStatus,
      @Body() UpdateStatusModel? updateStatusModel);

  @Post(path: '{matchId}/goals')
  Future<Response<void>> addGoal(
      @Path('matchId') int matchId, @Body() AddGoalModel goalModel);

  @Put(path: '{matchId}/goals/{goalId}')
  Future<Response<void>> editGoal(@Path('matchId') int matchId,
      @Path('goalId') int goalId, @Body() AddGoalModel goalModel);

  @Delete(path: '{matchId}/goals/{goalId}')
  Future<Response<void>> deleteGoal(
      @Path('matchId') int matchId, @Path('goalId') int goalId);

  @Get(path: '/scoretypes')
  Future<Response<ScoreTypeListModel>> getScoreType();

  @Put(path: '/{matchId}', headers: {'Content-Type': 'multipart/form-data'})
  @Multipart()
  Future<Response<MatchModel>> editMatch(
    @Path('matchId') int matchId,
    @Part() int primaryTeamId,
    @Part() String secondaryTeamName,
    @Part() String location,
    @Part() String league,
    @Part() String date,
    @Part() int isPublic,
    @Part() String? kickOffTime,
    @PartFile() String? file,
  );

  @Delete(path: '{matchId}')
  Future<Response<void>> deleteMatch(@Path('matchId') int matchId);

  @Post(path: '/addPublicMatches')
  Future<Response<void>> addPublicMatches(@Body() AddPublicMatchesRequestModel addPublicMatchesRequestModel);
}
