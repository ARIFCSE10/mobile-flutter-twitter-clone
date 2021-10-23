import 'package:get/get.dart';

import '../controllers/add_tweet_controller.dart';

class AddTweetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTweetController>(
      () => AddTweetController(),
    );
  }
}
