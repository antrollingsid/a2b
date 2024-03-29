// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/auth_controller.dart';
import '../../Components/widgets/accepted_offers_widgets.dart';
import '../../controllers/offert_controller.dart';
import '../mymap.dart';

final mycontroller = Get.put(OffertController());

class AcceptedOffers extends StatefulWidget {
  const AcceptedOffers({Key? key}) : super(key: key);

  @override
  _AcceptedOffers createState() => _AcceptedOffers();
}

class _AcceptedOffers extends State<AcceptedOffers> {
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return controller.user.role == 'courier'
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: context.primaryColor,
                title: const Text('Accepted Offers'),
              ),
              body: SafeArea(
                child: StreamBuilder<QuerySnapshot>(
                  stream: offersCollection
                      .where('status', isEqualTo: 'offer accepted')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No accepted offers found.'),
                      );
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic>? userData =
                            document.data() as Map<String, dynamic>?;

                        String from = userData?['locationDetaills']
                                ['pickupAddress'] ??
                            '';
                        String to = userData?['locationDetaills']
                                ['deliveryAddress'] ??
                            '';
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
                          future: applicationsCollection.doc().get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            String userName =
                                userData?['userDetails']['name'] ?? '';
                            String photoUrl =
                                userData?['userDetails']['userPhoto'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                Get.to(() => const MyApp());
                              },
                              child: AcceptedOfferView(
                                name: userName,
                                photoUrl: photoUrl,
                                date: date,
                                from: from,
                                to: to,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('You have no access.'),
              ],
            );
    });
  }
}
