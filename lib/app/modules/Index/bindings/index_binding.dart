import 'package:get/get.dart';

import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IndexController>(IndexController());
  }
}
