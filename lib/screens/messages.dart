import 'package:a2b/screens/chat/pages/chat_page.dart';
import 'package:a2b/screens/userDetails/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Components/widgets/offer_show.dart';
import '../../../controllers/auth_controller.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  _MessagesList createState() => _MessagesList();
}

class _MessagesList extends State<MessagesList> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  CollectionReference courierCollection =
      FirebaseFirestore.instance.collection('couriers');
  CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('chats');
  @override
  Widget build(BuildContext context) {
    final userRole = Get.put(AuthController());

    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: context.primaryColor,
          title: const Text('Messages'),
        ),
        body: SafeArea(
          child: userRole.user.role == 'courier'
              ? userRole.user.details.id ==
                      messagesCollection.doc(userRole.user.details.id).id
                  ? StreamBuilder<QuerySnapshot>(
                      stream: usersCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
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
                                String photoUrl =
                                    userData?['details']['photoURL'] ?? '';

                                return GestureDetector(
                                  onTap: () => Get.to(() => ChatPage(
                                        groupId: userRole.user.details.id,
                                        groupName: userName,
                                        userName: userRole.user.details.name,
                                        id: '',
                                        photo: '',
                                      )),
                                  child: OfferView(
                                    name: userName,
                                    photoUrl: photoUrl,
                                    date: 'date',
                                    from: 'from',
                                    to: 'to',
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    )
                  : userRole.user.role == 'general'
                      ? StreamBuilder<QuerySnapshot>(
                          stream: usersCollection.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Center(
                              child: SizedBox(
                                width: 333,
                                child: ListView(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic>? userData = document
                                        .data() as Map<String, dynamic>?;
                                    String userId = document.id;
                                    String userName =
                                        userData?['details']['name'] ?? '';
                                    String photoUrl =
                                        userData?['details']['photoURL'] ?? '';

                                    //String userRole = userData?['role'] ?? '';
                                    return GestureDetector(
                                      onTap: () => Get.to(() => ChatPage(
                                            groupId: userRole.user.details.id,
                                            groupName: userName,
                                            userName:
                                                userRole.user.details.name,
                                            id: '',
                                            photo: '',
                                          )),
                                      child: OfferView(
                                        name: userName,
                                        photoUrl: photoUrl,
                                        date: 'date',
                                        from: 'from',
                                        to: 'to',
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        )
                      : Text('data')
              : Text('error here'),
        ),
      );
    });
  }

  void _showDialog(BuildContext context, String userId, String userRole) {
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
}
