import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/data/db/firestore_db.dart';
import 'package:twitter_clone/app/service/user_auth.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    tweets = Get.find<FireStoreDB>().readAllTweet();
  }

  late final Stream<QuerySnapshot> tweets;
  String get userUid {
    return Get.find<UserAuth>().currentUser?.uid.toString() ?? '';
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

  Future<bool> editTweet({required DocumentReference doc}) async {
    return Get.find<FireStoreDB>().editTweet(doc);
  }

  Future<bool> deleteTweet({required DocumentReference doc}) async {
    return Get.find<FireStoreDB>().deleteTweet(doc);
  }
}
