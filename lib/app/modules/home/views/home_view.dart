import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/modules/home/widgets/tweet_widget.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
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
                if (!(Get.isSnackbarOpen ?? false)) {
                  Get.snackbar(_controller.user?.displayName ?? 'User Name',
                      _controller.user?.email ?? '--',
                      colorText: Colors.blueAccent,
                      snackPosition: SnackPosition.BOTTOM);
                }
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
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Get.toNamed(Routes.ADD_TWEET, arguments: <String, dynamic>{
            'is_editing_mode': false,
          }),
          child: Icon(Icons.add, color: Colors.white, size: 32),
          backgroundColor: Colors.blueGrey,
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
                var _doc =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                TweetModel _tweet = TweetModel.fromJson(_doc);
                return TweetWidget(
                    tweet: _tweet,
                    uid: _controller.userUid,
                    editAction: (() {
                      Get.toNamed(Routes.ADD_TWEET,
                          arguments: <String, dynamic>{
                            'is_editing_mode': true,
                            'tweet_reference':
                                snapshot.data!.docs[index].reference,
                            'status': _tweet.status,
                          });
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
