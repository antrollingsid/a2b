import 'package:a2b/Components/widgets/app_bar_buttons.dart';
import 'package:a2b/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';

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
                backgroundColor: const Color(0xFF0F9D58),
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
                            String userName =
                                userData?['details']['name'] ?? '';

                            return GestureDetector(
                              onTap: () {
                                _showDialog(context, userId, userName);
                              },
                              child: OfferView(
                                name: userName,
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
                _updateUserRole(userId, 'courier');
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

  void _updateUserRole(String userId, String role) {
    usersCollection
        .doc(userId)
        .update({
          'role': role,
        })
        .then((value) => print('User role updated successfully'))
        .catchError((error) => print('Failed to update user role: $error'));
  }
}

// import 'package:a2b/Components/widgets/app_bar_buttons.dart';
// import 'package:a2b/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nb_utils/nb_utils.dart';

// import '../../../Components/widgets/offer_show.dart';
// import '../../../controllers/auth_controller.dart';

// class UserApplication extends StatelessWidget {
//   UserApplication({Key? key}) : super(key: key);

//   CollectionReference applicationsCollection =
//       FirebaseFirestore.instance.collection('applications');

//   CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');

//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();

//     return GetBuilder<AuthController>(
//       builder: (controller) {
//         // ...

//         return Obx(() {
//           return authController.user.role == 'admin'
//               ? Scaffold(
//                   appBar: AppBar(
//                     backgroundColor: const Color(0xFF0F9D58),
//                     title: const Text('Applications'),
//                   ),
//                   body: SafeArea(
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: applicationsCollection.snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }
//                         return Center(
//                           child: SizedBox(
//                             width: 333,
//                             child: ListView(
//                               children: snapshot.data!.docs
//                                   .map((DocumentSnapshot document) {
//                                 Map<String, dynamic>? userData =
//                                     document.data() as Map<String, dynamic>?;
//                                 String userId = document.id;
//                                 String userName =
//                                     userData?['details']['name'] ?? '';

//                                 return GestureDetector(
//                                   onTap: () {
//                                     _showDialog(context, userId, userName);
//                                   },
//                                   child: OfferView(
//                                     name: userName,
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 )
//               : const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text('you have no access'),
//                   ],
//                 );
//         });
//       },
//     );
//   }

//   void _showDialog(BuildContext context, String userId, String userName) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Offer'),
//           content: Text('Do you accept this offer?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Accept'),
//               onPressed: () {
//                 // Perform accept action
//                 _updateUserRole(userId, 'courier');
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Decline'),
//               onPressed: () {
//                 // Perform decline action
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updateUserRole(String userId, String role) {
//     usersCollection
//         .doc(userId)
//         .update({
//           'role': role,
//         })
//         .then((value) => print('User role updated successfully'))
//         .catchError((error) => print('Failed to update user role: $error'));
//   }
// }
