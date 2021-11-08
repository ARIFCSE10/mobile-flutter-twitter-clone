import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_tweet_controller.dart';

class AddTweetView extends GetView<AddTweetController> {
  final int _maxLimit = 280;
  final AddTweetController _controller = Get.find<AddTweetController>();
  final TextEditingController _statusController =
      TextEditingController(text: Get.arguments['status'] ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_controller.isEditingMode ? 'Edit' : 'Add'} Tweet'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _getStatusField(),
          Divider(
            height: 16,
            thickness: 1,
          ),
          _getTweetButton(),
        ],
      ),
    );
  }

  _getStatusField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Obx(
        (() => TextField(
              keyboardType: TextInputType.multiline,
              autofocus: true,
              controller: _statusController,
              onChanged: (String status) {
                _controller.tweetStatus.value =
                    status.substring(0, min(status.length, 280));
              },
              maxLines: 10,
              minLines: 8,
              maxLength: _maxLimit,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                counterText:
                    '${_controller.tweetStatus.value.length}/$_maxLimit',
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 48, maxWidth: 48),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: Colors.blueGrey),
                ),
                hintText: 'Whats on your mind',
                suffixIconConstraints:
                    BoxConstraints(maxHeight: 48, maxWidth: 48),
              ),
            )),
      ),
    );
  }

  _getTweetButton() {
    return ElevatedButton(
      onPressed: (() async {
        if (_statusController.text.isEmpty) {
          if (!(Get.isSnackbarOpen ?? false)) {
            Get.snackbar('Error', 'Please write something',
                colorText: Colors.redAccent,
                snackPosition: SnackPosition.BOTTOM);
          }
          return;
        }
        bool _success = _controller.isEditingMode
            ? await _controller.editTweet(status: _statusController.text.trim())
            : await _controller.addTweet(status: _statusController.text.trim());
        if (_success) {
          Get.back();
        }
      }),
      child: Text('${_controller.isEditingMode ? 'Update' : 'Add'} Tweet'),
    );
  }
}
