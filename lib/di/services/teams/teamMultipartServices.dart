import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/services/interceptors/CustomResponseInterceptor.dart';
import 'package:score_keeper/di/services/interceptors/requestInterceptor.dart';
import 'package:score_keeper/utils/stringUtils.dart';

part 'teamMultipartServices.chopper.dart';

@ChopperApi(baseUrl: '/api/team')
abstract class TeamMultipartServices extends ChopperService {
  static TeamMultipartServices create([ChopperClient? client]) {
    final client = ChopperClient(
        baseUrl: Uri.http(StringUtils.BASE_URL_STAGING),
        services: [],
        errorConverter: const JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          CustomRequestInterceptor(),
          CustomResponseInterceptor()
        ]);

    return _$TeamMultipartServices(client);
  }
}
