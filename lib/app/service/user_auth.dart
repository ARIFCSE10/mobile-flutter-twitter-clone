import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserAuth extends GetxService {
  Future<bool> doUserLogin(
      {required String email, required String password}) async {
    try {
      final UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        printError(info: e.toString());
        Get.snackbar('Error', 'User Not Registered',
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        printError(info: e.toString());
        Get.snackbar('Error', 'User Credentials Error',
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      }
      return false;
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', 'User Login Failed!',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<bool> doUserSignup(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final UserCredential _user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _user.user?.updateDisplayName(name);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        Get.snackbar('Error', 'The password provided is too weak.',
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar('Error', 'The account already exists for that email.',
            colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      }
      return false;
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }

  User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  Future<bool> doUserLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'User ',
          colorText: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
