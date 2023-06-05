import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/auth_controller.dart';
import '../../controllers/offert_controller.dart';
import '../Components/widgets/order_activity.dart';

final mycontroller = Get.put(OffertController());

class OrderHistoryList extends StatefulWidget {
  const OrderHistoryList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrderHistoryList createState() => _OrderHistoryList();
}

class _OrderHistoryList extends State<OrderHistoryList> {
  final price = TextEditingController();
  final time = TextEditingController();
  CollectionReference courierCollection =
      FirebaseFirestore.instance.collection('couriers');
  CollectionReference applicationsCollection =
      FirebaseFirestore.instance.collection('accepted offers');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference offersCollection =
      FirebaseFirestore.instance.collection('offers');
  CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: context.primaryColor,
          title: const Text('Order History'),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: orderCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No accepted offers found.'),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic>? userData =
                      document.data() as Map<String, dynamic>?;
                  // String offerId = document.id;

                  String productName =
                      userData?['packageDetails']['productName'] ?? '';
                  String status = userData?['status'] ?? '';
                  Timestamp deliveryTimestamp =
                      userData?['deliveryDetails']?['deliveryDate'];
                  String date = deliveryTimestamp != null
                      ? DateFormat('dd/MM/yy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              deliveryTimestamp.seconds * 1000))
                      : '';

                  String courierId =
                      userData?['deliveryDetails']['deliverBy'] ?? '';

                  return FutureBuilder<DocumentSnapshot>(
                    future: courierCollection.doc(courierId).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      String courierName = (snapshot.data?.data()
                              as Map<String, dynamic>)['details']['name'] ??
                          '';
                      String photoUrl = (snapshot.data?.data()
                              as Map<String, dynamic>)['details']['photoURL'] ??
                          '';

                      return OrderHistoryActivity(
                        date: date,
                        productName: productName,
                        status: status,
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
      );
    });
  }
}
