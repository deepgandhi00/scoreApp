import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:score_keeper/screens/home/view/homeView.dart';
import 'package:score_keeper/screens/noConnection/views/noConnectionView.dart';

class ConnectionListenerController extends GetxController {
  final isConnected = true.obs;
  final previousRoute = ''.obs;
@override
void onInit() async {
  final customInstance = InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 10), // Custom check timeout
  );

  final bool isConnected = await customInstance.hasConnection;
  print('isConnected ${isConnected}');
  if (!isConnected) {
    Get.toNamed(NoConnectionView.routeName);
  }

  customInstance
      .onStatusChange
      .listen((InternetConnectionStatus status) {
    print('InternetConnectionStatus ${status}');
    if (status == InternetConnectionStatus.connected &&
        Get.currentRoute == NoConnectionView.routeName) {
      previousRoute.value = Get.previousRoute;
      Get.offAllNamed(HomeView.routeName);
    } else {
      Get.offAllNamed(NoConnectionView.routeName);
    }
  });
  super.onInit();
}
}
