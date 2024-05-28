import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as http;
import 'package:score_keeper/di/converters/builtValueConverter.dart';
import 'package:score_keeper/di/services/interceptors/CustomResponseInterceptor.dart';
import 'package:score_keeper/di/services/interceptors/requestInterceptor.dart';
import 'package:score_keeper/screens/matchesTabs/models/matchListModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/playerListModel.dart';
import 'package:score_keeper/screens/teamList/models/teamListModel.dart';
import 'package:score_keeper/screens/teamList/models/teamModel.dart';
import 'package:score_keeper/screens/teamPlayerList/models/addPlayerToTeamRequestModel.dart';
import 'package:score_keeper/utils/stringUtils.dart';

part 'teamService.chopper.dart';

@ChopperApi(baseUrl: '/api/team')
abstract class TeamService extends ChopperService {
  static TeamService create([ChopperClient? client]) {
    final client = ChopperClient(
        baseUrl: Uri.http(StringUtils.BASE_URL_STAGING),
        services: [],
        converter: BuiltValueConverter(),
        errorConverter: BuiltValueConverter(),
        client: http.IOClient(
          HttpClient()..connectionTimeout = const Duration(seconds: 8),
        ),
        interceptors: [
          HttpLoggingInterceptor(),
          CustomRequestInterceptor(),
          CustomResponseInterceptor()
        ]);

    return _$TeamService(client);
  }

  @Get(path: '/list')
  Future<Response<TeamListModel>> getTeams();

  @Post(path: 'create', headers: {'Content-Type': 'multipart/form-data'})
  @Multipart()
  Future<Response<void>> createTeam(
      @Part() String name, @PartFile() String? file);

  @Put(path: 'edit', headers: {'Content-Type': 'multipart/form-data'})
  @Multipart()
  Future<Response<void>> editTeam(
      @Part() int teamId, @Part() String name, @PartFile() String? file);

  @Delete(path: 'delete')
  Future<Response<void>> deleteTeam(@Body() TeamModel teamModel);

  @Get(path: '/{teamId}/players/')
  Future<Response<PlayerListModel>> getTeamPlayers(@Path() int teamId);

  @Post(path: '/{teamId}/players/')
  Future<Response<void>> addPlayersToTeam(
      @Body() AddPlayerToTeamRequestModel players, @Path() int teamId);

  @Delete(path: '{teamId}/player/{playerId}')
  Future<Response<void>> deletePlayerTeam(
      @Path('teamId') int teamId, @Path('playerId') int playerId);

  @Delete(path: '{teamId}/players')
  Future<Response<void>> deletePlayersFromTeam(
      @Path('teamId') int teamId, @Body() AddPlayerToTeamRequestModel players);

  @Get(path: '{teamId}/matches')
  Future<Response<MatchListModel>> getTeamMatches(@Path('teamId') int teamId);
}
