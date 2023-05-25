// view package
// package update
// view all user
// view rating

// rank system
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourierController extends GetxController {
  static CourierController get instance => Get.find();
  //TextField Controllers to get data from TextFields
  late final String  packageId;
  late final String courierId;
  late final String usererId;
  final duration = TextEditingController();
  final price = TextEditingController();
  final rate = TextEditingController();
  final comment = TextEditingController();

  // accept package or make offert
  Future<void> makeAnOffer(
     String offertId, String packageId, String courierId, String duration, double price) {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('offerts');
    return packages
        .doc(offertId)
        .set({
          'statut': 'pending',
          'packages': packageId,
          'deliverBy': courierId,
          'duration': duration,
          'price': price,
        })
        .then((value) => print("Offert made"))
        .catchError((error) => print("Failed to make an offert: $error"));
  }

  // rate user
  Future<void> rateUser(
      String userId, String courierId, String rate, String comment) {
    CollectionReference rates = FirebaseFirestore.instance.collection('rates');
    String? rateId;
    return rates.doc(rateId).set({
      'date': DateTime.now().toString(),
      'user': userId,
      'ratedBy': courierId,
      'rate': rate,
      'comment': comment,
    });
  }
}
