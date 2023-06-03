import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeOfferController extends GetxController {
  static MakeOfferController get instance => Get.find();
  final price = TextEditingController();
  final duration = TextEditingController();

  Future<void> updateOffer(context, price, duration) async {
    try {
      var response = FirebaseAuth.instance.currentUser;
      final userDocRef =
          FirebaseFirestore.instance.collection('orders').doc(response!.uid);
      var snapshot = await userDocRef.get();

      if (price != null && duration != null && context != null) {
        await userDocRef.update({
          'price': price,
          'deliveryDetails.duration': duration,
        });

        // Create a new document in the "offers" collection
        await FirebaseFirestore.instance
            .collection('offers')
            .doc(response!.uid)
            .set(
          {
            'price': price,
            'deliveryDetails.duration': duration,
          },
          SetOptions(merge: true),
        );
      }

      snapshot = await userDocRef.get();
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
