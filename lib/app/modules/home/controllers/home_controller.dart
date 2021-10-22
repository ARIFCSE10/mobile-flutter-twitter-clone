import 'package:get/get.dart';
import 'package:twitter_clone/app/service/user_auth.dart';

class HomeController extends GetxController {
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

  Future<bool> doUserLogout() async {
    return await Get.find<UserAuth>().doUserLogout();
  }
}
