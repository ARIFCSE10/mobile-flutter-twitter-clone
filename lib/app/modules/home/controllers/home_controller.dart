import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? get user {
    return Get.find<UserAuth>().currentUser;
  }

  String get userUid {
    return user?.uid.toString() ?? '';
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

  Future<bool> deleteTweet({required DocumentReference doc}) async {
    return Get.find<FireStoreDB>().deleteTweet(doc);
  }
}
