import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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

  Future<bool> deleteTweet(DocumentReference doc) async {
    late bool _success;
    await doc.delete().catchError((e) {
      _success = false;
      Get.snackbar('Error', 'Delete Failed',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      _success = true;
    });
    return _success;
  }

  Future<bool> editTweet(DocumentReference<Object?> doc) async {
    // late bool _success;
    // await doc.delete().catchError((e) {
    //   _success = false;
    //   Get.snackbar('Error', 'Delete Failed',
    //       colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    // }).whenComplete(() {
    //   _success = true;
    // });
    return true;
  }
}
