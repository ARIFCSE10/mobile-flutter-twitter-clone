import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';

class FireStoreDB extends GetxService {
  FirebaseFirestore get instance {
    return FirebaseFirestore.instance;
  }

  CollectionReference get tweets {
    return FirebaseFirestore.instance.collection('tweets');
  }

  Stream<QuerySnapshot> readAllTweet() {
    return tweets
        .orderBy('time', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  Future<bool> deleteTweet(DocumentReference tweetReference) async {
    late bool _success;
    await tweetReference.delete().catchError((e) {
      _success = false;
      Get.snackbar('Error', 'Delete Failed',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      _success = true;
    });
    return _success;
  }

  Future<bool> editTweet(
      {required DocumentReference<Object?> tweetReference,
      required TweetModel tweet}) async {
    late bool _success;
    await tweetReference.set(tweet.toJson()).whenComplete(() {
      _success = true;
    }).catchError((e) {
      _success = false;
      Get.snackbar('Error', 'Failed to edit Tweet',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    });
    return _success;
  }

  Future<bool> addTweet({required TweetModel tweet}) async {
    late bool _success;
    DocumentReference tweetReference = tweets.doc();
    await tweetReference.set(tweet.toJson()).whenComplete(() {
      _success = true;
    }).catchError((e) {
      _success = false;
      Get.snackbar('Error', 'Failed to post new Tweet',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    });
    return _success;
  }
}
