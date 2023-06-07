// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../dashboard/dashboard.dart';
import '../../qr_genartor.dart';
import '../order_summary.dart';
import '../order_upload_doc.dart';

class PackageController extends GetxController {
  static PackageController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  late DateTime delivery_date;
  late String sender_id = '';
  late String package_name;
  late String urlDownload;
  late String description;

  late String courrier_id = '';
  late String package_type;
  late String pickup_address;
  late String package_weight;
  late double pickupLatitude;
  late double pickupLongitude;
  late String delivery_address;
  late double deliveryLatitude;
  late String delivery_duration = '';
  late double deliveryLongitude;

  late bool IsFragile;
  late String IsAccepted;

  UploadTask? uploadTask;

  Future<Future<Null>> addPackage() async {
    courrier_id = "0";
    IsAccepted = "pending";

    final user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    final createdAt = DateTime.now();
    CollectionReference packages =
        FirebaseFirestore.instance.collection('orders');
    return packages.doc().set(
      {
        'createdAt': createdAt,
        'status': IsAccepted,
        'shippementstatut':
            'published', // here we have 4 shipement status published,accepted, shipping, recieved
        'userDetails': {
          'email': userSnapshot['details']['email'],
          'userPhoto': userSnapshot['details']['photoURL'],
          'name': userSnapshot['details']['name'],
          'surname': userSnapshot['details']['surname'],
          'number': userSnapshot['details']['phoneNumber'],
        },
        'packageDetails': {
          'productName': package_name,
          'weight': package_weight,
          'productType': package_type,
          'fragile': IsFragile,
          'productUrl': urlDownload,
        },
        'locationDetaills': {
          'pickupAddress': pickup_address,
          'pickupLatitude': pickupLatitude,
          'pickupLongitude': pickupLongitude,
          'deliveryAddress': delivery_address,
          'deliveryLatitude': deliveryLatitude,
          'deliveryLongitude': deliveryLongitude,
        },
        'deliveryDetails': {
          'deliveryDate': delivery_date,
          'sentBy': user.uid,
          'deliverBy': courrier_id,
          'duration': delivery_duration,
        },
        'price': 0.0,
        'description': description,
      },
    ).then((value) {
      QRCodeGenerator(
        courrierid: courrier_id,
        deliverydate: createdAt,
        packagename: package_name,
        packagetype: package_type,
        packageweight: package_weight,
        pickupaddress: pickup_address,
        senderid: user.uid,
      );
      Get.offAll(() => const DashBoard());
    })
        // Get.offAll(() => const DashBoard());
        .catchError((error) => print("Failed to add package: $error"));
  }

  Future<void> acceptPackage(String courierId, String duration, double price) {
    courrier_id = "0";
    IsAccepted = "yes";
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    return packages
        .doc()
        .update({
          'status': IsAccepted,
          'deliverBy': courrier_id,
          'duration': duration,
          'price': price,
        })
        .then((value) => print("Package Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void setOrderUploadDetails(
    BuildContext context,
    String productName,
    String urlDownload,
    String description,
    bool isfragile,
  ) {
    package_name = productName;
    this.urlDownload = urlDownload;
    this.description = description;
    IsFragile = isfragile;

    Get.to(() => const OrderSummary());
  }

  void setOrderMapDetails(
    BuildContext context,
    String type,
    String weight,
    String pickupAddress,
    String deliveryAddress,
    DateTime deliveryDate,
    double pickupLatitude,
    double pickupLongitude,
    double deliveryLatitude,
    double deliveryLongitude,
  ) {
    package_type = type;
    package_weight = weight;
    pickup_address = pickupAddress;
    delivery_address = deliveryAddress;
    delivery_date = deliveryDate;
    this.pickupLatitude = pickupLatitude;
    this.pickupLongitude = pickupLongitude;
    this.deliveryLatitude = deliveryLatitude;
    this.deliveryLongitude = deliveryLongitude;
    print('object');
    Get.to(() => const OrderUploadDoc());
  }

  dashboard() {
    print('order created');
    Get.offAll(() => const DashBoard());
  }
}
