// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../controllers/auth_controller.dart';
import '../../Components/widgets/courier_offer.dart';
import '../createOrder/order_map.dart';
import '../dashboard/dashboard.dart';
import '../profile/profile.dart';

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
            backgroundColor: context.primaryColor,
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
                  return const CircularProgressIndicator();
                }
                return Center(
                  child: SizedBox(
                    width: 333,
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic>? userData =
                            document.data() as Map<String, dynamic>;
                        String offerId = document.id;
                        String courierId =
                            userData['deliveryDetails']['deliverBy'] ?? '';

                        return FutureBuilder<DocumentSnapshot>(
                          future: courierCollection.doc(courierId).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
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
                            Timestamp deliveryTimestamp =
                                userData['deliveryDetails']['deliveryDate'];
                            String date = deliveryTimestamp != null
                                ? DateFormat('dd/MM/yy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        deliveryTimestamp.seconds * 1000))
                                : '';
                            String duration =
                                userData['deliveryDetails']['duration'] ?? '';
                            String pName =
                                userData['packageDetails']['productName'] ?? '';
                            String price = userData['price'] ?? '';

                            return GestureDetector(
                                onTap: () {
                                  _showDialog(context, offerId);
                                },
                                child: CourierOfferView(
                                  name: courierName,
                                  packageName: pName,
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
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.hintColor, // Choose your desired color
                  width: 1.0, // Choose your desired width
                ),
              ),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: context.scaffoldBackgroundColor,
              type: BottomNavigationBarType.fixed,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: context.secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.add,
                      color: context.scaffoldBackgroundColor,
                      size: 30,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outlined,
                    color: context.hintColor,
                  ),
                  label: '',
                ),
              ],
              selectedItemColor: context.primaryColor,
              onTap: (index) {
                if (index == 0) {
                  Get.to(() => const DashBoard());
                } else if (index == 1) {
                  Get.to(() => const PlaceOrderMap());
                } else if (index == 2) {
                  Get.to(() => const Profile());
                }
              },
            ),
          ));
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
