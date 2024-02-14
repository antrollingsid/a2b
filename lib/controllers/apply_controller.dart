import 'package:a2b/models/user_model.dart';
import 'package:a2b/screens/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void applyForCourier(BuildContext context, String url, String plateNo,
    String transportType) async {
  try {
    await addApplicationDetails(context, url, plateNo, transportType);
    Get.offAll(() => const DashBoard());
  } catch (e) {
    // final snackBar = SnackBar(content: Text(e.toString()));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // print('Error saving user data $e');
    Get.offAll(() => const DashBoard());
  }
}

Future addApplicationDetails(BuildContext context, String url, String plateNo,
    String transportType) async {
  final createdAt = Timestamp.fromDate(DateTime.now());
  final user = FirebaseAuth.instance.currentUser!;
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  final json = {
    'createdAt': createdAt,
    'details': {
      'id': user.uid,
      'name': userSnapshot['details']['name'],
      'surname': userSnapshot['details']['surname'],
      'email': userSnapshot['details']['email'],
      'photoURL': userSnapshot['details']['photoURL'],
    },
    'role': userSnapshot['role'],
    'documents': {
      'licence': url,
      'plateNo': plateNo,
      'transportType': transportType,
    },
    'decision': 'pending',
  };

  try {
    await FirebaseFirestore.instance
        .collection('applications')
        .doc(user.uid)
        .set(json);

    UserModel newUser = UserModel.fromJson(json);

    print(newUser);
    Get.offAll(() => const DashBoard());
  } on FirebaseException {
    Get.offAll(() => const DashBoard());
    // print('Error saving user data ${e.message}');
  }
}
