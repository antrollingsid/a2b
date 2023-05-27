import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();
  final name = TextEditingController();
  final surname = TextEditingController();
  final phoneNumber = TextEditingController();

  Future<void> updateName(name) async {
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
      snapshot = await userDocRef.get();
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<void> updateSurname(
    surname,
  ) async {
    try {
      var response = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(response!.uid);
      var snapshot = await userDocRef.get();

      if (surname != null) {
        await userDocRef.update({
          'details.surname': surname,
        });
      }

      snapshot = await userDocRef.get();
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<void> updatePhoneNumber(
    phoneNumber,
  ) async {
    try {
      var response = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(response!.uid);
      var snapshot = await userDocRef.get();

      if (phoneNumber != null) {
        await userDocRef.update({
          'details.phoneNumber': phoneNumber,
        });
      }

      snapshot = await userDocRef.get();
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
