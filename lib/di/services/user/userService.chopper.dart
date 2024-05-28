// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$UserService extends UserService {
  _$UserService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<UserModel>> editProfile(String file) {
    final Uri $url = Uri.parse('/api/user/');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<String>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<UserModel>> getProfile() {
    final Uri $url = Uri.parse('/api/user/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserModel, UserModel>($request);
  }

  @override
  Future<Response<void>> deleteUser() {
    final Uri $url = Uri.parse('/api/user/');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<void, void>($request);
  }
}
