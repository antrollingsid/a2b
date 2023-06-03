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
import '../../Components/widgets/accepted_offers_widgets.dart';
import '../../controllers/offert_controller.dart';
import '../../main/utils/Colors.dart';
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
                backgroundColor: const Color(0xFF0F9D58),
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
                      return CircularProgressIndicator();
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text('No accepted offers found.'),
                      );
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic>? userData =
                            document.data() as Map<String, dynamic>?;
                        String offerId = document.id;

                        String from = userData?['deliveryDetails']
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
                          future: courierCollection.doc(courierId).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            String courierName = (snapshot.data?.data()
                                        as Map<String, dynamic>)['details']
                                    ['name'] ??
                                '';
                            String photoUrl = (snapshot.data?.data()
                                        as Map<String, dynamic>)['details']
                                    ['photoURL'] ??
                                '';

                            return GestureDetector(
                              onTap: () {
                                Get.to(() => MyApp());
                              },
                              child: AcceptedOfferView(
                                name: courierName,
                                photoUrl: photoUrl,
                                date: date,
                                from: from,
                                to: 'to',
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
