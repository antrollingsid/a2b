import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';
import '../../controllers/offert_controller.dart';
import '../../main/utils/Colors.dart';



final mycontroller = Get.put(OffertController());
class AcceptedOffers extends StatefulWidget {
  const AcceptedOffers({Key? key}) : super(key: key);

  @override
  _AcceptedOffers createState() => _AcceptedOffers();
}

class _AcceptedOffers extends State<AcceptedOffers> {
  CollectionReference applicationsCollection =
      FirebaseFirestore.instance.collection('orders');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

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
                      return CircularProgressIndicator();
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

                            String userName = userData?['locationDetaills']
                                    ['deliveryAddress'] ??
                                '';

                            return GestureDetector(
                              onTap: () {
                                _showDialog(context, userId, userName);
                              },
                              child: OfferView(
                                name: userName,
                                photoUrl: '',
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
              title: "Accept Offert",
              content: Column(
                children: <Widget>[
                  TextField(
                    controller: mycontroller.price,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.verified_user_rounded),
                      labelText: 'Price',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  color: AppColors.buttonBlue,
                  onPressed: () {
                   
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Change",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
        }


  Future<void> _acceptApplication(String userId, String role) async {
    DocumentSnapshot userSnapshot =
        await applicationsCollection.doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // Update user role in the 'users' collection
    await usersCollection.doc(userId).update({'role': role});

    // Update user role and decision in the 'applications' collection
    await applicationsCollection.doc(userId).update({
      'decision': 'accepted',
      'role': role,
    });

    final createdAt = Timestamp.fromDate(DateTime.now());
    final json = {
      'createdAt': createdAt,
      'decision': 'accepted',
      'details': {
        'id': userData['details']['id'],
        'name': userData['details']['name'],
        'surname': userData['details']['surname'],
        'email': userData['details']['email'],
        'photoURL': userData['details']['photoURL'],
      },
      'role': role,
      'documents': {
        'licence': userData['documents']['licence'],
        'plateNo': userData['documents']['plateNo'],
        'transportType': userData['documents']['transportType'],
      },
    };

    // Add replicated data to the 'couriers' collection
    await FirebaseFirestore.instance.collection('offers').doc(userId).set(json);

    UserModel newUser = UserModel.fromJson(json);

    print(newUser);

    // Delete the replicated data from the 'applications' collection
    await applicationsCollection.doc(userId).delete();
  }

  Future<void> _declineApplication(String userId, String role) async {
    DocumentSnapshot userSnapshot =
        await applicationsCollection.doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // Update user role in the 'users' collection
    await usersCollection.doc(userId).update({'role': role});

    // Update user role and decision in the 'applications' collection
    await applicationsCollection.doc(userId).update({
      'decision': 'rejected',
      'role': role,
    });

    final createdAt = Timestamp.fromDate(DateTime.now());
    final json = {
      'createdAt': createdAt,
      'decision': 'rejected',
      'details': {
        'id': userData['details']['id'],
        'name': userData['details']['name'],
        'surname': userData['details']['surname'],
        'email': userData['details']['email'],
        'photoURL': userData['details']['photoURL'],
      },
      'role': role,
      'documents': {
        'licence': userData['documents']['licence'],
        'plateNo': userData['documents']['plateNo'],
        'transportType': userData['documents']['transportType'],
      },
    };

    // Add replicated data to the 'couriers' collection
    await FirebaseFirestore.instance
        .collection('rejectedOffers')
        .doc(userId)
        .set(json);

    UserModel newUser = UserModel.fromJson(json);

    print(newUser);

    // Delete the replicated data from the 'applications' collection
    await applicationsCollection.doc(userId).delete();
  }

  }