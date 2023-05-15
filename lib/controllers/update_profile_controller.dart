import 'package:a2b/main/utils/colors.dart';
import 'package:a2b/main/utils/constants.dart';
import 'package:a2b/models/user_model.dart';
import 'package:a2b/screens/dashboard.dart';
import 'package:a2b/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  late UserModel _user;
  UserModel get user => _user;

  Future<void> updateUserDetails(
    BuildContext context,
    String? name,
    String? surname,
    String? age,
  ) async {
    try {
      var response = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(response!.uid);
      var snapshot = await userDocRef.get();

      if (name != null) {
        await userDocRef.update({
          'details.name': name,
        });
      }

      if (surname != null) {
        await userDocRef.update({
          'details.surname': surname,
        });
      }

      if (age != null) {
        await userDocRef.update({
          'details.age': age,
        });
      }

      snapshot = await userDocRef.get();
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
