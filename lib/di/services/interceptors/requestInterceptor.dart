import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomRequestInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('accessToken')) {
      String accessToken = preferences.getString("accessToken")!;
      print('access ${accessToken}');
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    print('requestBody ${request.body}');
    return request;
  }
}
