import 'package:chopper/chopper.dart';
import 'package:score_keeper/di/services/auth/authService.dart';

part 'chopperClient.chopper.dart';

@ChopperApi(baseUrl: 'https://localhost:8080')
abstract class ApiServices extends ChopperService {
  static ApiServices create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('/api'),
      services: [AuthService.create()],
      converter: const JsonConverter(),
    );

    return _$ApiServices(client);
  }
}