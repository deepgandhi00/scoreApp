import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/custom/networkImageWithPlaceholder.dart';
import 'package:score_keeper/components/loadingScreen/loadingScreen.dart';
import 'package:score_keeper/screens/home/controllers/homeController.dart';
import 'package:score_keeper/screens/profile/views/profileView.dart';
import 'package:score_keeper/utils/colors.dart';
import 'package:score_keeper/utils/utils.dart';

class HomeView extends StatelessWidget {
  static String routeName = '/home';
  HomeController homeController = Get.find();

  HomeView({Key? key}) : super(key: key);

  void showConfirmLogoutSheet(BuildContext context) {
    Utils.showConfirmBottomSheet(
      onDeletePress: Utils.logoutUser,
      isLoading: API_STATUS.IDLE.obs,
      title: '',
      message: 'Are you sure you want to logout?',
      deleteButtonText: 'Logout',
      cancelButtonText: 'Cancel',
    );
  }

  void closeDialog() {
    Get.back();
  }

  void fileSelectCallBack(XFile xFile) {
    homeController.filePath.value = xFile;
  }

  // Widget getTeamImage() {
  //   if (homeController.filePath.value != null ||
  //       (homeController.user.value != null &&
  //           homeController.user.value!.photo != null)) {
  //     return GestureDetector(
  //       onTap: () =>
  //           Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
  //       child: NetworkImageWithPlaceHolder(
  //         imageUrl: homeController.user.value!.photo,
  //         filePath: homeController.filePath.value != null
  //             ? homeController.filePath.value!.path
  //             : null,
  //       ),
  //     );
  //   } else {
  //     return GestureDetector(
  //       onTap: () =>
  //           Utils.onPickImagePress(fileSelectCallBack: fileSelectCallBack),
  //       child: Container(
  //         width: 120,
  //         height: 120,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(120),
  //           color: CustomColors.imagePickBackground,
  //         ),
  //         child: const Center(
  //           child: Image(
  //             image: AssetImage('assets/images/camera_icon.png'),
  //             width: 32,
  //             height: 32,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // void showProfileDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Obx(
  //           () => AlertDialog(
  //             contentPadding: EdgeInsets.zero,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             content: Container(
  //               width: MediaQuery.of(context).size.width - 32,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(16),
  //                 color: CustomColors.appBarColor,
  //               ),
  //               child: Stack(
  //                 children: [
  //                   Positioned(
  //                     top: 8,
  //                     right: 16,
  //                     child: GestureDetector(
  //                       onTap: () => closeDialog(),
  //                       child: const Image(
  //                         image: AssetImage('assets/images/close_icon.png'),
  //                         width: 18,
  //                         height: 18,
  //                       ),
  //                     ),
  //                   ),
  //                   Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       const SizedBox(
  //                         height: 24,
  //                       ),
  //                       getTeamImage(),
  //                       const SizedBox(height: 24,),
  //                       Text(
  //                         homeController.user.value != null &&
  //                             homeController.user.value!.email != null &&
  //                             homeController.user.value!.email.isNotEmpty
  //                             ? homeController.user.value!.email
  //                             : '',
  //                         style: const TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: Colors.white),
  //                       ),
  //                       const SizedBox(
  //                         height: 24,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16),
  //                         child: BaseButton(
  //                           onPressed: homeController.onEditProfile,
  //                           text: 'Okay',
  //                           isLoading: homeController.UPDATE_STATUS.value ==
  //                               API_STATUS.LOADING,
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         height: 12,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  void onClickProfile() {
    Get.toNamed(ProfileView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.STATUS.value == API_STATUS.SUCCESS ||
              homeController.STATUS.value == API_STATUS.ERROR
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: CustomColors.appBarColor,
                elevation: 0,
                title: Text(
                  Utils.homeTabsTitle[
                      homeController.selectedCurrentTabIndex.value],
                ),
                titleSpacing: 16,
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: onClickProfile,
                      child: NetworkImageWithPlaceHolder(
                        imageUrl: homeController.user.value != null
                            ? homeController.user.value!.photo
                            : null,
                        width: 48,
                        placeholderAssetPath: 'assets/images/user_placeholder.png',
                      ),
                    ),
                  ],
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: CustomColors.appBarColor,
                ),
              ),
              body:
                  Utils.homeTabs[homeController.selectedCurrentTabIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: CustomColors.appBarColor,
                currentIndex: homeController.selectedCurrentTabIndex.value,
                onTap: (int index) => homeController.onTabPress(index),
                selectedItemColor: CustomColors.primaryColor,
                unselectedLabelStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                selectedLabelStyle:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                items: [
                  BottomNavigationBarItem(
                    icon: Image(
                      image: const AssetImage('assets/images/teams.png'),
                      width: 24,
                      height: 24,
                      color: homeController.selectedCurrentTabIndex.value == 0
                          ? CustomColors.primaryColor
                          : CustomColors.lightGray,
                    ),
                    label: 'Teams',
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                      image: const AssetImage('assets/images/matches.png'),
                      width: 24,
                      height: 24,
                      color: homeController.selectedCurrentTabIndex.value == 1
                          ? CustomColors.primaryColor
                          : CustomColors.lightGray,
                    ),
                    label: 'Matches',
                  ),
                  BottomNavigationBarItem(
                    icon: Image(
                      image: const AssetImage(
                        'assets/images/players.png',
                      ),
                      width: 24,
                      height: 24,
                      color: homeController.selectedCurrentTabIndex.value == 2
                          ? CustomColors.primaryColor
                          : CustomColors.lightGray,
                    ),
                    label: 'Players',
                  ),
                ],
              ),
            )
          : const LoadingScreen(),
    );
  }
}
