import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:score_keeper/utils/utils.dart';

class CustomResponseInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    if (response.statusCode == 401) {
      Utils.logoutUser();
    }
    return response;
  }

}