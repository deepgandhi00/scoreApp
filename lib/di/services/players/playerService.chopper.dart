// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$PlayerService extends PlayerService {
  _$PlayerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PlayerService;

  @override
  Future<Response<PlayerListModel>> getPlayers() {
    final Uri $url = Uri.parse('/api/player/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PlayerListModel, PlayerListModel>($request);
  }

  @override
  Future<Response<PositionsListModel>> getPositions() {
    final Uri $url = Uri.parse('/api/player/positions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PositionsListModel, PositionsListModel>($request);
  }

  @override
  Future<Response<dynamic>> addPlayer(
    String name,
    int? positionId,
    int? initialTeamId,
    String? tag,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/player/create');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'name',
        name,
      ),
      PartValue<int?>(
        'positionId',
        positionId,
      ),
      PartValue<int?>(
        'initialTeamId',
        initialTeamId,
      ),
      PartValue<String?>(
        'tagName',
        tag,
      ),
      PartValueFile<String?>(
        'file',
        file,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<void>> editPlayer(
    String name,
    int? positionId,
    int playerId,
    String? tag,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/player/edit');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'name',
        name,
      ),
      PartValue<int?>(
        'positionId',
        positionId,
      ),
      PartValue<int>(
        'playerId',
        playerId,
      ),
      PartValue<String?>(
        'tagName',
        tag,
      ),
      PartValueFile<String?>(
        'file',
        file,
      ),
    ];
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> deletePlayer(Player player) {
    final Uri $url = Uri.parse('/api/player/delete');
    final $body = player;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<PlayerDetailModel>> getPlayerDetails(int playerId) {
    final Uri $url = Uri.parse('/api/player/${playerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PlayerDetailModel, PlayerDetailModel>($request);
  }

  @override
  Future<Response<TagsListModel>> getTags() {
    final Uri $url = Uri.parse('/api/player/tags');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TagsListModel, TagsListModel>($request);
  }

  @override
  Future<Response<void>> createTags(AddTagsModel addTagsModel) {
    final Uri $url = Uri.parse('/api/player/tags');
    final $body = addTagsModel;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }
}
