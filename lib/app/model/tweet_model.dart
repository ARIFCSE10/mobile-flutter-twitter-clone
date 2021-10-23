class Tweet {
  Tweet({this.uid, this.name, this.status, this.time});
  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
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
