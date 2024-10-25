import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../../main.dart';
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
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: CustomAppBar(
              titleText: language.couriers,
              isActionVisible: false,
              isLeadingVisible: true,
            ),
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
                      children: snapshot.data!.docs.map(
                        (DocumentSnapshot document) {
                          Map<String, dynamic>? userData =
                              document.data() as Map<String, dynamic>?;
                          String userId = document.id;
                          String userName = userData?['details']['name'] ?? '';
                          String userSurName =
                              userData?['details']['surname'] ?? '';
                          String photoUrl =
                              userData?['details']['photoURL'] ?? '';
                          String userRole = userData?['role'] ?? '';

                          return GestureDetector(
                            onTap: () => Get.to(() => DetailsPage(userId)),
                            child: userRole == 'courier'
                                ? OfferView(
                                    name: userName,
                                    surname: userSurName,
                                    photoUrl: photoUrl,
                                    date: 'date',
                                    from: 'from',
                                    to: 'to',
                                  )
                                : Container(),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
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
