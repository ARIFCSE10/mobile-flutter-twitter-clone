import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/app/service/user_auth.dart';
import 'package:twitter_clone/app/utils/widget_utils.dart';

import '../controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  @override
  Widget build(BuildContext context) {
    _loadUserRoute();
    return Scaffold(body: Loader());
  }

  void _loadUserRoute() {
    SchedulerBinding.instance?.addPostFrameCallback(
      (Duration timeStamp) {
        Future.delayed(Duration(milliseconds: 100), () {
          User? user = Get.find<UserAuth>().currentUser;
          if (user == null) {
            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        });
      },
    );
  }
}
