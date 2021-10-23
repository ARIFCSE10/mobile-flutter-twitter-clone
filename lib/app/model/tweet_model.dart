class TweetModel {
  TweetModel({this.uid, this.name, this.status, this.time});
  factory TweetModel.fromJson(Map<String, dynamic> json) => TweetModel(
        uid: json['uid'] == null ? null : json['uid'],
        name: json['name'] == null ? null : json['name'],
        status: json['status'] == null ? null : json['status'],
        time: json['time'] == null ? null : json['time'].toDate(),
      );

  String? uid;
  String? name;
  String? status;
  DateTime? time;
}
