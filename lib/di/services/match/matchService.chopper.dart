// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$MatchService extends MatchService {
  _$MatchService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MatchService;

  @override
  Future<Response<MatchListModel>> getMatches() {
    final Uri $url = Uri.parse('/api/match/list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MatchListModel, MatchListModel>($request);
  }

  @override
  Future<Response<void>> createMatch(
    int primaryTeamId,
    String secondaryTeamName,
    String location,
    String league,
    String date,
    String lineups,
    String substitutes,
    int isPublic,
    String? kickOffTime,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/match/create');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<int>(
        'primaryTeamId',
        primaryTeamId,
      ),
      PartValue<String>(
        'secondaryTeamName',
        secondaryTeamName,
      ),
      PartValue<String>(
        'location',
        location,
      ),
      PartValue<String>(
        'league',
        league,
      ),
      PartValue<String>(
        'date',
        date,
      ),
      PartValue<String>(
        'lineups',
        lineups,
      ),
      PartValue<String>(
        'substitutes',
        substitutes,
      ),
      PartValue<int>(
        'isPublic',
        isPublic,
      ),
      PartValue<String?>(
        'kickOffTime',
        kickOffTime,
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
  Future<Response<MatchModel>> getMatchSummery(int matchId) {
    final Uri $url = Uri.parse('/api/match/${matchId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MatchModel, MatchModel>($request);
  }

  @override
  Future<Response<MatchPlayersModel>> getMatchPlayers(int matchId) {
    final Uri $url = Uri.parse('/api/match/${matchId}/players');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MatchPlayersModel, MatchPlayersModel>($request);
  }

  @override
  Future<Response<void>> editPlayersOfMatch(
    int matchId,
    UpdatePlayersRequest updatePlayersRequest,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}/players');
    final $body = updatePlayersRequest;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<MatchModel>> updateMatchStatus(
    int matchId,
    MatchStatusEnum matchStatus,
    UpdateStatusModel? updateStatusModel,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}/status/${matchStatus}');
    final $body = updateStatusModel;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MatchModel, MatchModel>($request);
  }

  @override
  Future<Response<void>> addGoal(
    int matchId,
    AddGoalModel goalModel,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}/goals');
    final $body = goalModel;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> editGoal(
    int matchId,
    int goalId,
    AddGoalModel goalModel,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}/goals/${goalId}');
    final $body = goalModel;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> deleteGoal(
    int matchId,
    int goalId,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}/goals/${goalId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<ScoreTypeListModel>> getScoreType() {
    final Uri $url = Uri.parse('/api/match/scoretypes');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ScoreTypeListModel, ScoreTypeListModel>($request);
  }

  @override
  Future<Response<MatchModel>> editMatch(
    int matchId,
    int primaryTeamId,
    String secondaryTeamName,
    String location,
    String league,
    String date,
    int isPublic,
    String? kickOffTime,
    String? file,
  ) {
    final Uri $url = Uri.parse('/api/match/${matchId}');
    final Map<String, String> $headers = {
      'Content-Type': 'multipart/form-data',
    };
    final List<PartValue> $parts = <PartValue>[
      PartValue<int>(
        'primaryTeamId',
        primaryTeamId,
      ),
      PartValue<String>(
        'secondaryTeamName',
        secondaryTeamName,
      ),
      PartValue<String>(
        'location',
        location,
      ),
      PartValue<String>(
        'league',
        league,
      ),
      PartValue<String>(
        'date',
        date,
      ),
      PartValue<int>(
        'isPublic',
        isPublic,
      ),
      PartValue<String?>(
        'kickOffTime',
        kickOffTime,
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
    return client.send<MatchModel, MatchModel>($request);
  }

  @override
  Future<Response<void>> deleteMatch(int matchId) {
    final Uri $url = Uri.parse('/api/match/${matchId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<void>> addPublicMatches(
      AddPublicMatchesRequestModel addPublicMatchesRequestModel) {
    final Uri $url = Uri.parse('/api/match/addPublicMatches');
    final $body = addPublicMatchesRequestModel;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }
}
