import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:score_keeper/di/services/auth/authService.dart';
import 'package:score_keeper/di/services/user/userService.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/home/models/userModel.dart';
import 'package:score_keeper/screens/profile/models/logoutRequestModel.dart';
import 'package:score_keeper/utils/firebaseMessagingUtils.dart';
import 'package:score_keeper/utils/utils.dart';

class ProfileController extends GetxController {
  Rxn<UserModel> user = Rxn<UserModel>();
  HomeController homeController = Get.find();
  final STATUS = API_STATUS.IDLE.obs;
  UserService userService = Get.find();
  final filePath = Rxn<XFile>();
  final UPDATE_STATUS = API_STATUS.IDLE.obs;
  final areNotificationEnabled = Rx<bool>(false);
  AuthService authService = Get.find();
  final LOGOUT_STATUS = API_STATUS.IDLE.obs;
  final appVersion = Rxn<String>();

  @override
  void onReady() async {
    STATUS.value = API_STATUS.LOADING;
    user.value = homeController.user.value;

    if (user.value == null) {
      getUserDetails();
    } else {
      STATUS.value = API_STATUS.SUCCESS;
    }

    checkNotificationsEnabled();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;
    super.onReady();
  }

  void getUserDetails() async {
    final response = await userService.getProfile();

    if (response.isSuccessful) {
      user.value = response.body!;
      STATUS.value = API_STATUS.SUCCESS;
    } else {
      var error = response.error as Map<String, dynamic>;
      STATUS.value = API_STATUS.ERROR;
      Utils.showErrorBottomSheet(
          message: error['message'],
          onOkayPress: () {
            filePath.value = null;
          });
    }
  }

  void onEditProfile() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;
    final response = await userService.editProfile(filePath.value!.path);

    if (response.isSuccessful) {
      user.value = response.body;
      homeController.onEditProfile(user.value!);
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
    } else {
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
      UPDATE_STATUS.value = API_STATUS.ERROR;
    }
  }

  void deleteUser() async {
    UPDATE_STATUS.value = API_STATUS.LOADING;

    final response = await userService.deleteUser();
    if (response.isSuccessful) {
      UPDATE_STATUS.value = API_STATUS.SUCCESS;
      Utils.logoutUser();
    } else {
      Get.back();
      var error = response.error as Map<String, dynamic>;
      Utils.showErrorBottomSheet(message: error['message']);
      UPDATE_STATUS.value = API_STATUS.ERROR;
    }
  }

  void checkNotificationsEnabled() async {
    final bool isEnabled =
        await FirebaseMessagingUtils.checkIfNotificationsAreEnabled();
    areNotificationEnabled.value = isEnabled;
  }

  void onLogoutClick() async {
    String? deviceId = await getDeviceId();
    LOGOUT_STATUS.value = API_STATUS.LOADING;
    LogoutRequestModel logoutRequestModel =
        LogoutRequestModel((b) => b..deviceId = deviceId ?? '');
    print('logoutRequestModel $logoutRequestModel');
    final response = await authService.logout(logoutRequestModel);

    if (response.isSuccessful) {
      LOGOUT_STATUS.value = API_STATUS.SUCCESS;
      Utils.logoutUser();
    } else {
      LOGOUT_STATUS.value = API_STATUS.ERROR;
      Utils.logoutUser();
    }
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.device; // unique ID on Android
    }
  }
}
