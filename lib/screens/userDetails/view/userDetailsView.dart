import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:score_keeper/components/buttons/baseButton.dart';
import 'package:score_keeper/components/textFields/baseTextField.dart';
import 'package:score_keeper/screens/userDetails/controller/userDetailsController.dart';
import 'package:score_keeper/utils/utils.dart';

class UserDetailsView extends StatelessWidget {
  static final String routeName = '/userDetails';
  UserDetailsController userDetailsController = Get.find();

  UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Text(
                'Let us know a bit about yourself',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 32,
              ),
              // input
              Obx(
                () => BaseTextField(
                  labelText: 'First Name',
                  hasBorder: true,
                  isRequired: true,
                  controller: userDetailsController.firstNameController,
                  showUnderLineBorder: true,
                  errorText: userDetailsController.firstNameError.value,
                  onChange: userDetailsController.onChangeFirstName,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => BaseTextField(
                  labelText: 'Last Name',
                  hasBorder: true,
                  isRequired: true,
                  controller: userDetailsController.lastNameController,
                  showUnderLineBorder: true,
                  errorText: userDetailsController.lastNameError.value,
                  onChange: userDetailsController.onChangeLastName,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              BaseButton(
                onPressed: userDetailsController.onPressDone,
                text: 'Continue',
                isEnabled: true,
                isLoading:
                    userDetailsController.STATUS.value == API_STATUS.LOADING,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
