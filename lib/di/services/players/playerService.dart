import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/converters/builtValueConverter.dart';
import 'package:score_keeper/di/services/interceptors/CustomResponseInterceptor.dart';
import 'package:score_keeper/di/services/interceptors/requestInterceptor.dart';
import 'package:score_keeper/models/tagsListModel.dart';
import 'package:score_keeper/models/tagsModel.dart';
import 'package:score_keeper/screens/playerDetails/models/playerDetailModel.dart';
import 'package:score_keeper/screens/playerList/models/addTagsModel/addTagsModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/addPlayerRequestModel.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/player.dart';
import 'package:score_keeper/screens/playerList/models/playerModels/playerListModel.dart';
import 'package:score_keeper/screens/playerList/models/positionModels/positionsListModel.dart';
import 'package:http/io_client.dart' as http;
import 'package:score_keeper/utils/stringUtils.dart';

part 'playerService.chopper.dart';

@ChopperApi(baseUrl: '/api/player')
abstract class PlayerService extends ChopperService {
  static PlayerService create([ChopperClient? client]) {
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

    return _$PlayerService(client);
  }

  @Get(path: '/list')
  Future<Response<PlayerListModel>> getPlayers();

  @Get(path: '/positions')
  Future<Response<PositionsListModel>> getPositions();

  @Post(path: '/create')
  @Multipart()
  Future<Response> addPlayer(
    @Part('name') String name,
    @Part('positionId') int? positionId,
    @Part('initialTeamId') int? initialTeamId,
    @Part('tagName') String? tag,
    @PartFile() String? file,
  );

  @Put(path: '/edit')
  @Multipart()
  Future<Response<void>> editPlayer(
    @Part('name') String name,
    @Part('positionId') int? positionId,
    @Part('playerId') int playerId,
    @Part('tagName') String? tag,
    @PartFile() String? file,
  );

  @Delete(path: '/delete')
  Future<Response<void>> deletePlayer(@Body() Player player);

  @Get(path: '{playerId}')
  Future<Response<PlayerDetailModel>> getPlayerDetails(
    @Path('playerId') int playerId,
  );

  @Get(path: '/tags')
  Future<Response<TagsListModel>> getTags();

  @Post(path: '/tags')
  Future<Response<void>> createTags(@Body() AddTagsModel addTagsModel);
}
