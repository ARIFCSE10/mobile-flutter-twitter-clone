import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/app/service/user_auth.dart';

class LoginController extends GetxController {
  final Rx<String> emailErrorText = ''.obs;
  final Rx<String> passwordErrorText = ''.obs;
  final Rx<bool> passwordVisibility = true.obs;
  final Rx<bool> isValidInput = false.obs;
  final Rx<bool> isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  /// Email Validation
  /// returns true for valid email
  bool validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      emailErrorText.value = 'Please give a valid email';
      return false;
    } else {
      emailErrorText.value = '';
      return true;
    }
  }

  /// Password Validation
  /// returns true for 6 - 10 digits AlphaNumeric password
  bool validatePassword(String password) {
    const Pattern special = r'^[0-9a-zA-Z]{6,10}$';
    RegExp regex = RegExp(special.toString());
    if (!regex.hasMatch(password)) {
      passwordErrorText.value = 'Password should be 6-10 digit alpha-numeric';
      return false;
    } else {
      passwordErrorText.value = '';
      return true;
    }
  }

  togglePasswordsVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  bool validateInput({String email = '', String password = ''}) {
    bool _validEmail = validateEmail(email);
    bool _validPassword = validatePassword(password);
    isValidInput.value = _validEmail && _validPassword;
    return isValidInput.value;
  }

  Future<bool> authVerify({String email = '', String password = ''}) async {
    /// :TODO: Check Auth
    if (!validateInput(email: email, password: password)) {
      if (!(Get.isSnackbarOpen ?? false)) {
        Get.snackbar('Error', 'User Input Error',
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      }
      return false;
    }
    isLoading.value = true;
    bool _response = await Get.find<UserAuth>()
        .doUserLogin(email: email, password: password);
    isLoading.value = false;
    return _response;
  }
}
