import 'package:a2b/main/utils/colors.dart';
import 'package:a2b/models/user_model.dart';
import 'package:a2b/screens/dashboard.dart';
import 'package:a2b/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late UserModel _user;
  UserModel get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void register(
      BuildContext context, String email, String password, String name) async {
    // Call api
    var navigator = Navigator.of(context);
    showDialog(
        context: context,
        builder: (context) {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.backgroundLightMode,
          );
        });

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => addUserDetails(value.user!.uid, email, name));

      navigator.pop();
      Get.offAll(() => const DashBoard());
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error saving user data ${e.message}');
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    // Call api
    var navigator = Navigator.of(context);
    showDialog(
        context: context,
        builder: (context) {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.backgroundLightMode,
          );
        });

    try {
      var response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(response.user!.uid)
          .get();

      var data = snapshot.data();
      UserModel newUser = UserModel.fromJson(data!);

      _user = newUser;
      _isLoggedIn = true;
      update();

      navigator.pop();
      Get.offAll(() => const DashBoard());
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error saving user data ${e.message}');
    }
  }

  Future addUserDetails(String uid, String email, String name) async {
    // Call api
    final createdAt = DateTime.now();
    final json = {
      'role': 'general',
      'createdAt': createdAt,
      'details': {
        'id': uid,
        'name': name,
        'email': email,
        'photoURL':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
      }
    };

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(json);

      UserModel newUser = UserModel.fromJson(json);
      _user = newUser;
      _isLoggedIn = true;
      update();

      print(newUser);
    } on FirebaseException catch (e) {
      print('Error saving user data ${e.message}');
    }
  }

  Future<void> signOut() async {
    _isLoggedIn = false;
    update();
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const SplashScreenPage());
  }
}
