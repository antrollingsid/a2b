// ignore_for_file: unnecessary_import

import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/main.dart';
import 'package:a2b/screens/chat/pages/chat_page.dart';
import 'package:a2b/screens/createOrder/order_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import '../../../../Components/widgets/app_bar_buttons.dart';
import '../../../../Components/widgets/order_activity.dart';
import '../../../../Components/widgets/shippement.dart';
import '../livemap.dart';
import '../offers/create_offer.dart';
import '../offers/accepted_offers.dart';
import '../profile/profile.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
    final userRole = Get.put(AuthController());
    final tracked = FirebaseFirestore.instance.collection('location');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Dashboard',
          isActionVisible: true,
          isLeadingVisible: false,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: userRole.user.role == 'general'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 150),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ship Your",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              // height:  1.5*ffem/fem,
                              // color: Color(0xffffffff),
                            ),
                          ),
                          Text(
                            'Package Safely',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              // wordSpacing: 1.5,
                              // letterSpacing: 1.5,
                              // height:  1.5*ffem/fem,
                              // color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const TrackingTextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => Get.to(() => MyMap1(
                              tracked.doc('user1').id,
                            )),
                        child: const CustomShip()),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 333,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            language.orderHistory,
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: applicationsCollection.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text('No accepted offers found.'),
                                );
                              }
                              return Container(
                                width: 333,
                                height: 199,
                                child: ListView(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic>? userData = document
                                        .data() as Map<String, dynamic>?;

                                    String productName =
                                        userData?['packageDetails']
                                                ?['productName'] ??
                                            '';
                                    String status = userData?['status'] ?? '';
                                    Timestamp? deliveryTimestamp =
                                        userData?['deliveryDetails']
                                            ?['deliveryDate'];
                                    String date = deliveryTimestamp != null
                                        ? DateFormat('dd/MM/yy').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                deliveryTimestamp.seconds *
                                                    1000))
                                        : '';

                                    String courierId =
                                        userData?['deliveryDetails']
                                                ?['deliverBy'] ??
                                            '';

                                    return FutureBuilder<DocumentSnapshot>(
                                      future: courierCollection
                                          .doc(courierId)
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<DocumentSnapshot>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        }

                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        }

                                        DocumentSnapshot? courierSnapshot =
                                            snapshot.data;

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
                                ),
                              );
                            }))
                  ],
                )
              : SafeArea(
                  child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const UsersOrders());
                      },
                      child: Container(
                        color: context.primaryColor,
                        height: 100,
                        width: 170,
                        child: Text(
                          'users orders',
                          style:
                              TextStyle(color: context.scaffoldBackgroundColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const AcceptedOffers());
                      },
                      child: Container(
                        color: context.primaryColor,
                        height: 100,
                        width: 170,
                        child: Text(
                          'accepted offers',
                          style:
                              TextStyle(color: context.scaffoldBackgroundColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
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
      ),
    );
  }
}

class TrackingTextField extends StatelessWidget {
  const TrackingTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: Center(
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.string(
                  SvgConstant.searchIconDark,
                  width: 19,
                  height: 19,
                ),
              ),
              hintText: 'Tracking code',
              hintStyle: const TextStyle(color: AppColors.textGrey),
              filled: true,
              fillColor: context.scaffoldBackgroundColor,
              border: GradientOutlineInputBorder(
                gradient: LinearGradient(
                    colors: [
                      context.primaryColor,
                      context.primaryColor,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                width: 1,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
