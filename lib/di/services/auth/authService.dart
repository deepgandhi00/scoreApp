import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/converters/builtValueConverter.dart';
import 'package:score_keeper/screens/enterEmail/models/generateOtpRequestModel.dart';
import 'package:score_keeper/screens/profile/models/logoutRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpRequestModel.dart';
import 'package:score_keeper/screens/verifyEmail/models/verifyOtpResponseModel.dart';
import 'package:http/io_client.dart' as http;
import 'package:score_keeper/utils/stringUtils.dart';

part 'authService.chopper.dart';

@ChopperApi(baseUrl: '/api/auth')
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) {
    final client = ChopperClient(
        baseUrl: Uri.http(StringUtils.BASE_URL_STAGING),
        client: http.IOClient(
          HttpClient()..connectionTimeout = const Duration(seconds: 8),
        ),
        services: [],
        converter: BuiltValueConverter(),
        errorConverter: BuiltValueConverter(),
        interceptors: [HttpLoggingInterceptor()]);

    return _$AuthService(client);
  }

  @Post(path: '/sendotp')
  Future<Response<void>> generateOtpForEmailVerification(
    @Body() GenerateOtpRequestModel generateOtpRequest,
  );

  @Post(path: '/login')
  Future<Response<VerifyOtpResponseModel>> verifyOtp(
      @Body() VerifyOtpRequestModel verifyOtpRequestModel);

  @Post(path: '/logout')
  Future<Response<void>> logout(@Body() LogoutRequestModel logoutRequestModel);
}
