import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/modules/home/widgets/tweet_widget.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/app/service/user_auth.dart';
import 'package:twitter_clone/app/utils/widget_utils.dart';

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
                //:TODO:
                printInfo(info: '${Get.find<UserAuth>().currentUser?.uid}');
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
        body: _contentView());
  }

  _contentView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.tweets,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Loader();
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var tweet =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return TweetWidget(
                    tweet: TweetModel.fromJson(tweet),
                    uid: _controller.userUid,
                    editAction: (() {
                      printInfo(info: 'Edit');
                    }),
                    deleteAction: (() {
                      _controller
                          .deleteTweet(
                              doc: snapshot.data!.docs[index].reference)
                          .then((bool success) {
                        if (success) {
                          Get.snackbar('Success', 'Tweet Deleted',
                              colorText: Colors.blueAccent,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      });
                    }));
              });
        }
        return Loader();
      },
    );
  }
}
