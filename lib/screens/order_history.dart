import 'package:a2b/main/utils/colors.dart';
import 'package:a2b/screens/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controllers/auth_controller.dart';
import '../../controllers/offert_controller.dart';
import '../Components/widgets/order_activity.dart';
import 'createOrder/order_map.dart';
import 'dashboard/dashboard.dart';

final mycontroller = Get.put(OffertController());

class OrderHistoryList extends StatefulWidget {
  const OrderHistoryList({Key? key}) : super(key: key);

  @override
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
              stream: applicationsCollection.snapshots(),
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

                    String productName =
                        userData?['packageDetails']?['productName'] ?? '';
                    String status = userData?['status'] ?? '';
                    Timestamp? deliveryTimestamp =
                        userData?['deliveryDetails']?['deliveryDate'];
                    String date = deliveryTimestamp != null
                        ? DateFormat('dd/MM/yy').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                deliveryTimestamp.seconds * 1000))
                        : '';

                    String courierId =
                        userData?['deliveryDetails']?['deliverBy'] ?? '';

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

                        DocumentSnapshot? courierSnapshot = snapshot.data;

                        if (!snapshot.hasData ||
                            courierSnapshot == null ||
                            courierSnapshot.data() == null) {
                          // Handle the case when the courier document is not found or has no data
                          return OrderHistoryActivity(
                            date: date,
                            productName: productName,
                            status: status,
                          );
                        }

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
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: context.accentColor, // Choose your desired color
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
                      color: AppColors.accent,
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
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outlined,
                    color: Colors.black,
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
}
