import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/modules/home/widgets/tweet_widget.dart';
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
        body: StreamBuilder<QuerySnapshot>(
          stream: _controller.tweets,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var tweet = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return TweetWidget(
                      tweet: TweetModel.fromJson(tweet),
                      uid: _controller.userUid,
                      docId: snapshot.data!.docs[index].id,
                    );
                  });
            }
            return Text('Something went wrong');
          },
        ));
  }
}
