import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final Rx<String> emailErrorText = ''.obs;
  final Rx<String> passwordErrorText = ''.obs;
  final Rx<bool> passwordVisibility = true.obs;
  final Rx<bool> isValidInput = false.obs;

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

  bool validateEmail(String email) {
    if (!GetUtils.isEmail(email)) {
      emailErrorText.value = 'Please give a valid email';
      return false;
    } else {
      emailErrorText.value = '';
      return true;
    }
  }

  bool validatePassword(String password) {
    if (password.length < 6 || password.length > 10) {
      passwordErrorText.value = 'Password length is 6-10';
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
    if (validateEmail(email) && validatePassword(password)) {
      isValidInput.value = true;
      return true;
    } else {
      isValidInput.value = false;
      return false;
    }
  }

  authVerify({String? email, String? password}) {
    /// :TODO: Check Auth
    var error = true;
    if (error) {
      Get.snackbar('Error', 'Wrong User Input');
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
