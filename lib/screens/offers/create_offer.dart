// ignore_for_file: unnecessary_null_comparison

import 'package:a2b/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';
import '../../controllers/offert_controller.dart';
import '../../main/utils/Colors.dart';

final mycontroller = Get.put(OffertController());

class UsersOrders extends StatefulWidget {
  const UsersOrders({Key? key}) : super(key: key);

  @override
  _UsersOrders createState() => _UsersOrders();
}

class _UsersOrders extends State<UsersOrders> {
  final price = TextEditingController();
  final time = TextEditingController();

  CollectionReference applicationsCollection =
      FirebaseFirestore.instance.collection('orders');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      // ...

      return controller.user.role == 'courier'
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF0F9D58),
                title: const Text('Make Offer'),
              ),
              body: SafeArea(
                child: StreamBuilder<QuerySnapshot>(
                  stream: applicationsCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Center(
                      child: SizedBox(
                        width: 333,
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic>? userData =
                                document.data() as Map<String, dynamic>?;
                            String userId = document.id;

                            String from = userData?['locationDetaills']
                                    ['deliveryAddress'] ??
                                '';
                            Timestamp deliveryTimestamp =
                                userData?['deliveryDetails']?['deliveryDate'];
                            String date = deliveryTimestamp != null
                                ? DateFormat('dd/MM/yy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        deliveryTimestamp.seconds * 1000))
                                : '';

                            String to = userData?['locationDetaills']
                                    ['pickupAddress'] ??
                                '';
                            String userName =
                                userData?['userDetails']['name'] ?? '';

                            String userPhoto =
                                userData?['userDetails']['userPhoto'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                _showDialog(context, userId, userName);
                              },
                              child: OfferView(
                                name: userName,
                                photoUrl: userPhoto,
                                date: date,
                                from: from,
                                to: to,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('you have no access'),
              ],
            );
    });
  }

  void _showDialog(BuildContext context, String userId, String userName) {
    Alert(
      context: context,
      title: "Accept Offer",
      content: Column(
        children: <Widget>[
          TextField(
            controller: price,
            decoration: InputDecoration(
              icon: const Icon(Icons.verified_user_rounded),
              labelText: language.price,
            ),
          ),
          TextField(
            controller: time,
            decoration: InputDecoration(
              icon: const Icon(Icons.verified_user_rounded),
              labelText: language.deliverTime,
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: AppColors.buttonBlue,
          onPressed: () {
            updateOffer(
                user.uid, price.text, time.text, userId); // Pass text values
            Navigator.pop(context);
          },
          child: const Text(
            "Change",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  Future<void> updateOffer(uid, price, duration, userId) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('orders').doc(userId);
      var snapshot = await userDocRef.get();

      if (price != null && duration != null && uid != null) {
        await userDocRef.update({
          'price': price,
          'deliveryDetails.duration': duration,
          'deliveryDetails.deliverBy': user.uid,
          'status': 'offer created',
        });
      }

      // Get the updated data
      snapshot = await userDocRef.get();
      Map<String, dynamic> updatedData =
          snapshot.data() as Map<String, dynamic>;

      // Create a new document in the "offers" collection with the updated data
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(userId)
          .set(updatedData);

      UserModel.fromJson(updatedData);
      print('After update: ${snapshot.data()?['details']}');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
