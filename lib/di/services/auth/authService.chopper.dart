// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthService;

  @override
  Future<Response<void>> generateOtpForEmailVerification(
      GenerateOtpRequestModel generateOtpRequest) {
    final Uri $url = Uri.parse('/api/auth/sendotp');
    final $body = generateOtpRequest;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }

  @override
  Future<Response<VerifyOtpResponseModel>> verifyOtp(
      VerifyOtpRequestModel verifyOtpRequestModel) {
    final Uri $url = Uri.parse('/api/auth/login');
    final $body = verifyOtpRequestModel;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<VerifyOtpResponseModel, VerifyOtpResponseModel>($request);
  }

  @override
  Future<Response<void>> logout(LogoutRequestModel logoutRequestModel) {
    final Uri $url = Uri.parse('/api/auth/logout');
    final $body = logoutRequestModel;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<void, void>($request);
  }
}
