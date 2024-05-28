import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/screens/profile/controllers/profileController.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileView extends StatefulWidget {
  static String routeName = '/profile';

  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with WidgetsBindingObserver {
  ProfileController profileController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      profileController.checkNotificationsEnabled();
    }
  }

  void fileSelectCallBack(XFile xFile) {
    profileController.filePath.value = xFile;
    profileController.onEditProfile();
  }

  void onContactUsClick() {
    final Uri url = Uri.parse('https://google.com');
    launchUrl(url, mode: LaunchMode.externalApplication).catchError((err) {
      print(err.toString());
    });
  }

  void onPrivacyPolicyClick() {
    final Uri url = Uri.parse('https://google.com');
    launchUrl(url, mode: LaunchMode.externalApplication).catchError((err) {
      print(err.toString());
    });
  }

  void showConfirmLogoutSheet(BuildContext context) {
    Utils.showConfirmBottomSheet(
      onDeletePress: profileController.onLogoutClick,
      isLoading: profileController.LOGOUT_STATUS,
      title: '',
      message: 'Are you sure you want to logout?',
      deleteButtonText: 'Logout',
      cancelButtonText: 'Cancel',
    );
  }

  void onDeletePress(BuildContext context) {
    Utils.showConfirmBottomSheet(
      onDeletePress: profileController.deleteUser,
      isLoading: profileController.LOGOUT_STATUS,
      title: '',
      message:
          'Are you sure you want to delete your account? You will permanently lose all your data.',
      deleteButtonText: 'Delete',
      cancelButtonText: 'Cancel',
    );
  }

  void onNotificationsClicked() {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  void onBackPress() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: CustomColors.background,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => profileController.STATUS.value == API_STATUS.SUCCESS
                ? Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          getTeamImage(),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            profileController.user.value != null
                                ? profileController.user.value!.email
                                : '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          getCard(
                            title: 'Contact Us',
                            onPress: onContactUsClick,
                            imagePath: 'assets/images/contact_us.png',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          getCard(
                            title: 'Privacy Policy',
                            onPress: onPrivacyPolicyClick,
                            imagePath: 'assets/images/privacy_policy.png',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          getCard(
                            title: 'Notifications',
                            onPress: () => showConfirmLogoutSheet(context),
                            imagePath: 'assets/images/privacy_policy.png',
                            trailingWidget: Switch(
                              value: profileController
                                  .areNotificationEnabled.value,
                              onChanged: (bool val) {
                                onNotificationsClicked();
                              },
                              activeColor: CustomColors.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          getCard(
                            title: 'Logout',
                            onPress: () => showConfirmLogoutSheet(context),
                            imagePath: 'assets/images/logout.png',
                          ),
                          Expanded(child: Container()),
                          Text(
                            profileController.appVersion.value ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              getCard(
                                title: 'Delete Your Account',
                                onPress: () => onDeletePress(context),
                                imagePath: 'assets/images/delete.png',
                                isDelete: true,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'Your data will be permanently lost upon account deletion.',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: CustomColors.darkGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: onBackPress,
                        ),
                      ),
                    ],
                  )
                : const LoadingScreen(),
          ),
        ),
      ),
    );
  }

  Widget getTeamImage() {
    if (profileController.filePath.value != null ||
        (profileController.user.value != null &&
            profileController.user.value!.photo != null)) {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: Stack(
          children: [
            NetworkImageWithPlaceHolder(
              imageUrl: profileController.user.value != null
                  ? profileController.user.value!.photo
                  : null,
              filePath: profileController.filePath.value != null
                  ? profileController.filePath.value!.path
                  : null,
              width: 100,
            ),
            Positioned(
                bottom: 0,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.primaryColor,
                  ),
                  child: const Image(
                    width: 14,
                    height: 14,
                    image: AssetImage('assets/images/edit_icon.png'),
                  ),
                ))
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () =>
            Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: CustomColors.imagePickBackground,
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/images/camera_icon.png'),
              width: 32,
              height: 32,
            ),
          ),
        ),
      );
    }
  }

  Widget getCard({
    required String title,
    required Function onPress,
    required String imagePath,
    bool isDelete = false,
    Widget? trailingWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => onPress(),
        child: Container(
          padding: isDelete
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: CustomColors.appBarColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  isDelete
                      ? Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: CustomColors.backgroundDark,
                          ),
                          child: Center(
                            child: Image.asset(
                              imagePath,
                              width: 22,
                              height: 22,
                              color: CustomColors.backgroundDark,
                            ),
                          ),
                        )
                      : Image.asset(
                          imagePath,
                          width: 32,
                          height: 32,
                          color: CustomColors.appBarColor,
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isDelete ? CustomColors.primaryRed : Colors.white),
                  ),
                ],
              ),
              trailingWidget ??
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: isDelete ? CustomColors.primaryRed : Colors.white,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
