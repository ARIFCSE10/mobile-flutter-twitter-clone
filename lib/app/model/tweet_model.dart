import 'package:cloud_firestore/cloud_firestore.dart';

class TweetModel {
  TweetModel({this.uid, this.name, this.status, this.time});
  factory TweetModel.fromJson(Map<String, dynamic> json) => TweetModel(
        uid: json['uid'] == null ? null : json['uid'],
        name: json['name'] == null ? null : json['name'],
        status: json['status'] == null ? null : json['status'],
        time: (json['time'] == null || json['time'] is String)
            ? DateTime.tryParse(json['time']) ?? DateTime.now()
            : json['time']?.toDate() ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid == null ? null : uid,
        'name': name == null ? null : name,
        'status': status == null ? null : status,
        'time':
            time == null ? null : Timestamp.fromDate(time ?? DateTime.now()),
      };

  String? uid;
  String? name;
  String? status;
  DateTime? time;
}
