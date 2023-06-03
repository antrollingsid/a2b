import 'package:a2b/screens/offers_user_side.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../Components/widgets/courier_offer.dart';
import '../userDetails/details.dart';

class CourierOfferList extends StatefulWidget {
  const CourierOfferList({Key? key}) : super(key: key);

  @override
  _CourierOfferList createState() => _CourierOfferList();
}

class _CourierOfferList extends State<CourierOfferList> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('offers');
  CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('offers');
  CollectionReference courierCollection =
      FirebaseFirestore.instance.collection('couriers');
  CollectionReference acceptedOffersCollection =
      FirebaseFirestore.instance.collection('accepted offers');
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F9D58),
          title: const Text('offers'),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: usersCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Center(
                child: SizedBox(
                  width: 333,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic>? userData =
                          document.data() as Map<String, dynamic>?;
                      String offerId = document.id;
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
                                  as Map<String, dynamic>)['details']['name'] ??
                              '';
                          String photoUrl = (snapshot.data?.data()
                                      as Map<String, dynamic>)['details']
                                  ['photoURL'] ??
                              '';
                          Timestamp deliveryTimestamp =
                              userData?['deliveryDetails']?['deliveryDate'];
                          String date = deliveryTimestamp != null
                              ? DateFormat('dd/MM/yy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      deliveryTimestamp.seconds * 1000))
                              : '';

                          String duration =
                              userData?['deliveryDetails']['duration'] ?? '';
                          String price = userData?['price'] ?? '';

                          return GestureDetector(
                              onTap: () {
                                _showDialog(context, offerId);
                              },
                              child: CourierOfferView(
                                name: courierName,
                                photoUrl: photoUrl,
                                price: price,
                                duration: duration,
                                date: date,
                              ));
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  void _showDialog(BuildContext context, String offerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Offer'),
          content: Text('Do you accept this offer?'),
          actions: <Widget>[
            TextButton(
              child: Text('Accept'),
              onPressed: () {
                _acceptOffer(offerId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Decline'),
              onPressed: () {
                // Perform decline action
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _acceptOffer(String offerId) async {
    DocumentSnapshot offerSnapshot = await usersCollection.doc(offerId).get();
    if (offerSnapshot.exists) {
      Map<String, dynamic>? offerData =
          offerSnapshot.data() as Map<String, dynamic>?;

      // Add offer to accepted offers collection
      await acceptedOffersCollection.doc(offerId).set(offerData);

      // Update status to "offer accepted" in the offers collection
      await usersCollection.doc(offerId).update({'status': 'offer accepted'});
      await ordersCollection.doc(offerId).update({'status': 'offer accepted'});
    }
  }
}
