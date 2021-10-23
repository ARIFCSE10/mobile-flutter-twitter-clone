import 'package:cloud_firestore/cloud_firestore.dart';
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
}
