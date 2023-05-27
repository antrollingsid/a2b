import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class RateController extends GetxController {
  Future<void> rateCourier(BuildContext context, String userId,
      String courierId, String rate, String comment) {
    CollectionReference rates =
        FirebaseFirestore.instance.collection('userToCourierRates');
    String? rateId;
    var navigator = Navigator.of(context);
    navigator.pop();
    return rates.doc(rateId).set({
      'date': DateTime.now().toString(),
      'courier': courierId,
      'ratedBy': userId,
      'rate': rate,
      'comment': comment,
    });
  }

  Future<void> rateUser(BuildContext context, String userId, String courierId,
      String rate, String comment) {
    CollectionReference rates =
        FirebaseFirestore.instance.collection('CourierToUserRates');
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
