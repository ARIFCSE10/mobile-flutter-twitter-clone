import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/app/utils/widget_utils.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final SignupController _controller = Get.find<SignupController>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Alpha Beta');
  final TextEditingController _emailController =
      TextEditingController(text: 'a@b.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signup'),
          centerTitle: true,
        ),
        body: Obx(
          () => Visibility(
              visible: !_controller.isLoading.value,
              replacement: Loader(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _getNameField(),
                  _getEmailField(),
                  _getPasswordField(),
                  _getRegisterButton(),
                ],
              )),
        ));
  }

  _getNameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Obx(
        (() => TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _nameController,
              onChanged: (String name) {
                _controller.validateName(name.trim());
              },
              maxLines: 1,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.account_circle,
                      size: 24,
                    ),
                  ),
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
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Enter Full Name',
                  suffixIconConstraints:
                      BoxConstraints(maxHeight: 48, maxWidth: 48),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  errorText: _controller.nameErrorText.isEmpty
                      ? null
                      : _controller.nameErrorText.value,
                  errorMaxLines: 1,
                  errorStyle: TextStyle(color: Colors.redAccent)),
            )),
      ),
    );
  }

  _getEmailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Obx(
        (() => TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              onChanged: (String email) {
                _controller.validateEmail(email.trim());
              },
              maxLines: 1,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.email,
                      size: 24,
                    ),
                  ),
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
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Enter email',
                  suffixIconConstraints:
                      BoxConstraints(maxHeight: 48, maxWidth: 48),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 2, color: Colors.red)),
                  errorText: _controller.emailErrorText.isEmpty
                      ? null
                      : _controller.emailErrorText.value,
                  errorMaxLines: 1,
                  errorStyle: TextStyle(color: Colors.redAccent)),
            )),
      ),
    );
  }

  _getPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Obx(() => TextField(
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            onChanged: (String password) {
              _controller.validatePassword(password);
            },
            maxLines: 1,
            obscureText: _controller.passwordVisibility.value,
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.password,
                    size: 24,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility, color: Colors.blueGrey),
                  onPressed: (() => _controller.togglePasswordsVisibility()),
                ),
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
                contentPadding: EdgeInsets.zero,
                hintText: 'Enter Password',
                suffixIconConstraints:
                    BoxConstraints(maxHeight: 48, maxWidth: 48),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(width: 2, color: Colors.red)),
                errorText: _controller.passwordErrorText.isEmpty
                    ? null
                    : _controller.passwordErrorText.value,
                errorMaxLines: 1,
                errorStyle: TextStyle(color: Colors.redAccent)),
          )),
    );
  }

  _getRegisterButton() {
    return ElevatedButton(
        onPressed: (() async {
          bool _success = await _controller.doRegister(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text);
          if (_success) {
            Get.offAllNamed(Routes.HOME);
          }
        }),
        child: Text(
          'Register',
        ));
  }
}
