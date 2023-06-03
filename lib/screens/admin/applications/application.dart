import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/application_offer_view.dart';
import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/user_model.dart';

class UserApplication extends StatefulWidget {
  const UserApplication({Key? key}) : super(key: key);

  @override
  _UserApplication createState() => _UserApplication();
}

class _UserApplication extends State<UserApplication> {
  CollectionReference applicationsCollection =
      FirebaseFirestore.instance.collection('applications');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      // ...

      return controller.user.role == 'admin'
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: context.primaryColor,
                title: const Text('Applications'),
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
                            Timestamp deliveryTimestamp =
                                userData?['createdAt'];
                            String date = deliveryTimestamp != null
                                ? DateFormat('dd/MM/yy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        deliveryTimestamp.seconds * 1000))
                                : '';
                            String userName =
                                userData?['details']['name'] ?? '';
                            String photoUrl =
                                userData?['details']['photoURL'] ?? '';
                            String licenseUrl =
                                userData?['documents']['licence'] ?? '';
                            String transportationType =
                                userData?['documents']['transportType'] ?? '';
                            return GestureDetector(
                              onTap: () {
                                _showDialog(context, userId, userName);
                              },
                              child: ApplicationOfferView(
                                name: userName,
                                photoUrl: photoUrl,
                                date: date,
                                transportationType: transportationType,
                                license: licenseUrl,
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
                // Perform accept action
                _acceptApplication(userId, 'courier');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Decline'),
              onPressed: () {
                _declineApplication(userId, 'general');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
    await FirebaseFirestore.instance
        .collection('couriers')
        .doc(userId)
        .set(json);

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
        .collection('rejectedApplications')
        .doc(userId)
        .set(json);

    UserModel newUser = UserModel.fromJson(json);

    print(newUser);

    // Delete the replicated data from the 'applications' collection
    await applicationsCollection.doc(userId).delete();
  }
}
