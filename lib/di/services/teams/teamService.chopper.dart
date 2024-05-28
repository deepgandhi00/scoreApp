// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$TeamService extends TeamService {
  _$TeamService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TeamService;

  @override
  Future<Response<TeamListModel>> getTeams() {
    final Uri $url = Uri.parse('/api/team/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TeamListModel, TeamListModel>($request);
  }

  @override
  Future<Response<void>> createTeam(
    String name,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/team/create');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'name',
        name,
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
      headers: $headers,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> editTeam(
    int teamId,
    String name,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/team/edit');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<int>(
        'teamId',
        teamId,
      ),
      PartValue<String>(
        'name',
        name,
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
      headers: $headers,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> deleteTeam(TeamModel teamModel) {
    final Uri $url = Uri.parse('/api/team/delete');
    final $body = teamModel;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<PlayerListModel>> getTeamPlayers(int teamId) {
    final Uri $url = Uri.parse('/api/team/${teamId}/players/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PlayerListModel, PlayerListModel>($request);
  }

  @override
  Future<Response<void>> addPlayersToTeam(
    AddPlayerToTeamRequestModel players,
    int teamId,
  ) {
    final Uri $url = Uri.parse('/api/team/${teamId}/players/');
    final $body = players;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> deletePlayerTeam(
    int teamId,
    int playerId,
  ) {
    final Uri $url = Uri.parse('/api/team/${teamId}/player/${playerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> deletePlayersFromTeam(
    int teamId,
    AddPlayerToTeamRequestModel players,
  ) {
    final Uri $url = Uri.parse('/api/team/${teamId}/players');
    final $body = players;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<MatchListModel>> getTeamMatches(int teamId) {
    final Uri $url = Uri.parse('/api/team/${teamId}/matches');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MatchListModel, MatchListModel>($request);
  }
}
