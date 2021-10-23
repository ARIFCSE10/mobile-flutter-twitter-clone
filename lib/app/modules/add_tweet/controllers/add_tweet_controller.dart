import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/data/db/firestore_db.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';
import 'package:twitter_clone/app/service/user_auth.dart';

class AddTweetController extends GetxController {
  final bool isEditingMode = Get.arguments['is_editing_mode'];
  late final DocumentReference<Object?> tweetReference;
  final Rx<String> tweetStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (isEditingMode) {
      tweetReference = Get.arguments['tweet_reference'];
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<bool> editTweet({required String status}) async {
    final String _name = Get.find<UserAuth>().currentUser?.displayName ?? '';
    final String _uid = Get.find<UserAuth>().currentUser?.uid ?? '';
    final DateTime _time = DateTime.now();
    TweetModel _tweet = TweetModel(
      name: _name,
      uid: _uid,
      time: _time,
      status: status,
    );
    return await Get.find<FireStoreDB>()
        .editTweet(tweetReference: tweetReference, tweet: _tweet);
  }

  Future<bool> addTweet({required String status}) async {
    final String _name = Get.find<UserAuth>().currentUser?.displayName ?? '';
    final String _uid = Get.find<UserAuth>().currentUser?.uid ?? '';
    final DateTime _time = DateTime.now();
    TweetModel _tweet = TweetModel(
      name: _name,
      uid: _uid,
      time: _time,
      status: status,
    );
    return await Get.find<FireStoreDB>().addTweet(tweet: _tweet);
  }
}
