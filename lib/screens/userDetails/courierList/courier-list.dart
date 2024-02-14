import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../../main/utils/colors.dart';
import '../../createOrder/order_map.dart';
import '../../dashboard/dashboard.dart';
import '../../profile/profile.dart';
import '../details.dart';

class CourierList extends StatefulWidget {
  const CourierList({Key? key}) : super(key: key);

  @override
  _CourierList createState() => _CourierList();
}

class _CourierList extends State<CourierList> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('couriers');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: context.primaryColor,
            title: const Text('Couriers'),
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
                            document.data() as Map<String, dynamic>?;
                        String userId = document.id;
                        String userName = userData?['details']['name'] ?? '';
                        String photoUrl =
                            userData?['details']['photoURL'] ?? '';

                        String userRole = userData?['role'] ?? '';

                        return GestureDetector(
                          onTap: () => Get.to(() => DetailsPage(userId)),
                          child: userRole == 'courier'
                              ? OfferView(
                                  name: userName,
                                  photoUrl: photoUrl,
                                  date: 'date',
                                  from: 'from',
                                  to: 'to',
                                )
                              : Container(),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors
                      .backgroundLightMode, // Choose your desired color
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
                      color: AppColors.backgroundLightMode,
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
                    color: AppColors.backgroundLightMode,
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

  void _showDialog(BuildContext context, String userId, String userRole) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Offer'),
          content: const Text('Do you accept this offer?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Decline'),
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
}
