import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/converters/builtValueConverter.dart';
import 'package:score_keeper/di/services/interceptors/CustomResponseInterceptor.dart';
import 'package:score_keeper/di/services/interceptors/requestInterceptor.dart';
import 'package:score_keeper/screens/home/models/userModel.dart';
import 'package:http/io_client.dart' as http;
import 'package:score_keeper/utils/stringUtils.dart';

part 'userService.chopper.dart';

@ChopperApi(baseUrl: '/api/user')
abstract class UserService extends ChopperService {
  static UserService create([ChopperClient? client]) {
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

    return _$UserService(client);
  }

  @Put(path: '/')
  @Multipart()
  Future<Response<UserModel>> editProfile(@PartFile() String file);

  @Get(path: '/')
  Future<Response<UserModel>> getProfile();

  @Delete(path: '/')
  Future<Response<void>> deleteUser();
}