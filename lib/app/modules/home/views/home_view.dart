import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/app/service/user_auth.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_box),
            tooltip: 'Profile',
            onPressed: () async {
              printInfo(
                  info: '${Get.find<UserAuth>().currentUser?.displayName}');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              bool _success = await _controller.doUserLogout();
              if (_success) {
                Get.offAllNamed(Routes.LOGIN);
              } else {
                Get.snackbar('Error', 'User Logout Failed',
                    colorText: Colors.redAccent,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
