// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  late final String package_id;
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
  Future<void> addPackage() {
    // Call the package's CollectionReference to add a new user
    courrier_id = "0";
    IsAccepted = "not";
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    return packages
        .doc(package_id)
        .set({
          'statut': IsAccepted,
          'sendedBy': sender_id,
          'deliverBy': courrier_id,
          'from': from,
          'to': to,
          'reference': address_ref,
          'reciever': reciever_name,
          'name': package_name,
          'hieght': package_hieght,
          'width': package_weight,
          'weight': package_weight,
          'date': delivery_date,
          'time': delivery_time,
          'fragile': IsFragile,
          'duration': delivery_duration,
          'price': 0.0,
          'url': urlDownload,
        })
        .then((value) => print("Package Added"))
        .catchError((error) => print("Failed to add package: $error"));
  }

  Future<void> acceptPackage(String courierId, String duration, double price) {
    courrier_id = "0";
    IsAccepted = "yes";
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    return packages
        .doc(package_id)
        .update({
          'statut': IsAccepted,
          'deliverBy': courrier_id,
          'duration': duration,
          'price': price,
        })
        .then((value) => print("Package Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
