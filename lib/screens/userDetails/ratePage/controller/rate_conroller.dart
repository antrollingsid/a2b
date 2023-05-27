import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class RateController extends GetxController {
  Future<void> rateCourier(
      String userId, String courierId, String rate, String comment) {
    CollectionReference rates = FirebaseFirestore.instance.collection('rates');
    String? rateId;
    return rates.doc(rateId).set({
      'date': DateTime.now().toString(),
      'courier': courierId,
      'ratedBy': userId,
      'rate': rate,
      'comment': comment,
    });
  }
}
