import 'dart:async';

import 'package:a2b/models/user_model.dart';
import 'package:a2b/screens/dashboard.dart';
import 'package:a2b/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  late UserModel _user;
  UserModel get user => _user;
  bool isLoaddIn = true;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void register(BuildContext context, String email, String password,
      String name, String surname) async {
    // Call api
    var navigator = Navigator.of(context);

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
              (value) => addUserDetails(value.user!.uid, email, name, surname));

      navigator.pop();
      isLoaddIn = false;
      Get.offAll(() => const DashBoard());
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      isLoaddIn = false;
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error saving user data ${e.message}');
    }
  }

  signInWithGoogle(BuildContext context) async {
    var navigator = Navigator.of(context);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo?.isNewUser == true) {
          final displayName = googleUser.displayName ?? '';
          final nameParts = displayName.split(' ');
          final givenName = nameParts.first;
          final surname = nameParts.length > 1 ? nameParts.last : '';

          final createdAt = DateTime.now();
          final userDetails = {
            'role': 'general',
            'createdAt': createdAt,
            'details': {
              'id': user.uid,
              'name': givenName,
              'surname': surname,
              'email': user.email ?? '',
              'photoURL': user.photoURL ?? '',
              'phoneNumber': user.phoneNumber ?? '',
            },
          };
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userDetails);

          _user = UserModel(
              role: 'general',
              createdAt: createdAt,
              details: Details(
                  id: user.uid,
                  name: givenName,
                  surname: surname,
                  email: user.email ?? '',
                  photoURL: user.photoURL ?? ''));
        }

        _isLoggedIn = true;
        update();
        isLoaddIn = false;
        navigator.pop();
        Get.offAll(() => const DashBoard());
      } else {}
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  void registerwithgoogle(BuildContext context, String email, String password,
      String name, String surname) async {
    // Call api
    var navigator = Navigator.of(context);

    try {
      await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
      navigator.pop();
      isLoaddIn = false;
      Get.offAll(() => const DashBoard());
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      isLoaddIn = true;
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error saving user data ${e.message}');
    }
  }

  void applyForCourier(BuildContext context, String email, String password,
      String name, String surname) async {
    // Call api
    var navigator = Navigator.of(context);
    if (isLoaddIn) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
              (value) => addUserDetails(value.user!.uid, email, name, surname),
            )
            .then((value) => isLoaddIn = false);

        navigator.pop();
        Get.offAll(() => const DashBoard());
      } on FirebaseAuthException catch (e) {
        navigator.pop();
        isLoaddIn = false;
        final snackBar = SnackBar(content: Text(e.message.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Error saving user data ${e.message}');
      }
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    // Call api
    var navigator = Navigator.of(context);

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
      isLoaddIn = false;
      navigator.pop();
      Get.offAll(() => const DashBoard());
    } on FirebaseAuthException catch (e) {
      navigator.pop();
      isLoaddIn = false;
      final snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('Error saving user data ${e.message}');
    }
  }

  // Future<void> updateUserDetails(
  //   BuildContext context,
  //   String? name,
  //   String? surname,
  //   String? age,
  // ) async {
  //   try {
  //     var response = FirebaseAuth.instance.currentUser;
  //     final userDocRef =
  //         FirebaseFirestore.instance.collection('users').doc(response!.uid);
  //     var snapshot = await userDocRef.get();

  //     if (name != null) {
  //       await userDocRef.update({
  //         'details.name': name,
  //       });
  //     }

  //     if (surname != null) {
  //       await userDocRef.update({
  //         'details.surname': surname,
  //       });
  //     }

  //     if (age != null) {
  //       await userDocRef.update({
  //         'details.age': age,
  //       });
  //     }

  //     snapshot = await userDocRef.get();
  //     print('After update: ${snapshot.data()?['details']}');
  //   } catch (e) {
  //     print('Error updating user details: $e');
  //   }
  // }

  Future addUserDetails(
      String uid, String email, String name, String surname) async {
    // Call api
    final createdAt = DateTime.now();
    final json = {
      'role': 'general',
      'createdAt': createdAt,
      'details': {
        'id': uid,
        'name': name,
        'surname': surname,
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
    GoogleSignIn().signOut();
    Get.offAll(() => const HomePage());
  }
}
