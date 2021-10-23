import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/data/db/firestore_db.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';

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
                Get.find<FireStoreDB>().readAllTweet();

                // printInfo(
                //     info: '${Get.find<UserAuth>().currentUser?.displayName}');
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
                    return _singleTweet(tweet: Tweet.fromJson(tweet));
                  });
            }
            return Text('Something went wrong');
          },
        ));
  }

  _singleTweet({Tweet? tweet}) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.campaign_outlined,
              size: 32,
              color: Colors.blueGrey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${tweet?.time}',
                    maxLines: 1,
                    style: TextStyle(fontSize: 12),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      '${tweet?.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${tweet?.status} ',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
