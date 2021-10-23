import 'package:flutter/material.dart';
import 'package:twitter_clone/app/model/tweet_model.dart';

class TweetWidget extends StatelessWidget {
  const TweetWidget({
    Key? key,
    required this.tweet,
    required this.uid,
    this.editAction,
    this.deleteAction,
  }) : super(key: key);
  final TweetModel? tweet;
  final String uid;
  final Null Function()? editAction;
  final Null Function()? deleteAction;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _contentView(),
            _actionView(),
          ]),
    );
  }

  _contentView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
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
                  style: TextStyle(fontSize: 10),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: Text(
                    '${tweet?.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1)),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                    '${tweet?.status} ',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _actionView() {
    return Visibility(
      visible: uid.isNotEmpty && uid == tweet?.uid,
      child: Column(
        children: [
          Divider(thickness: 2, height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _getEditButton(),
              _getDeleteButton(),
            ],
          ),
        ],
      ),
    );
  }

  _getEditButton() {
    return IconButton(
      onPressed: editAction,
      icon: Icon(
        Icons.edit,
        color: Colors.blueGrey,
        size: 32,
      ),
    );
  }

  _getDeleteButton() {
    return IconButton(
      onPressed: deleteAction,
      icon: Icon(
        Icons.delete_outlined,
        color: Colors.redAccent,
        size: 32,
      ),
    );
  }
}
