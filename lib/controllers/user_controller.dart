// add or create package done
// accept offert done
// rate courier  done
// view all courier done
// view rating with comment done
// track package
// rank system
// make payment
// qr generation

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

var rng = Random();
String package_id = (rng.nextInt(900000) + 100000).toString();

class CourierController extends GetxController {
  static CourierController get instance => Get.find();
  //TextField Controllers to get data from TextFields
  late final String packageId;
  late final String courierId;
  late final String usererId;
  final rate = TextEditingController();
  final comment = TextEditingController();
  late final String sender_id;
  late final String courrier_id;
  late final String delivery_duration;
  final from = TextEditingController();
  final to = TextEditingController();
  final address_ref = TextEditingController();
  final reciever_name = TextEditingController();
  final package_name = TextEditingController();
  final package_hieght = TextEditingController();
  final package_width = TextEditingController();
  final package_weight = TextEditingController();
  final delivery_date = TextEditingController();
  final delivery_time = TextEditingController();
  late bool IsFragile;
  late String IsAccepted;
  late String urlDownload;
  File? _file;
  PlatformFile? _platformFile;
  UploadTask? uploadTask;

  // accept package offert
  Future<void> AcceptAnOffer(
      String offertId, String packageId, String courierId) {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('offerts');
    return packages
        .doc(offertId)
        .update({
          'statut': 'accepted',
          'packages': packageId,
          'deliverBy': courierId,
          'userId': usererId,
        })
        .then((value) => print("Offert made"))
        .catchError((error) => print("Failed to make an offert: $error"));
  }

  // rate user
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

  // add or create package done in order controller
}
