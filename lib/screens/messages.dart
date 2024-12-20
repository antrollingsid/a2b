import 'package:a2b/screens/chat/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              ? StreamBuilder<QuerySnapshot>(
                  stream: messagesCollection
                      .where('courierId', isEqualTo: userRole.user.details.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Text('No chats found.');
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
                            String userName = userData?['userrName'] ?? '';
                            String userSurname = userData?['userrName'] ?? '';

                            String userPhoto = userData?['userPhoto'] ?? '';
                            String courierId = userData?['courierId'] ?? '';

                            return GestureDetector(
                              onTap: () => Get.to(() => ChatPage(
                                    groupId: userId,
                                    groupName: userName,
                                    userName: userRole.user.details.name,
                                    id: userId,
                                    photo: userPhoto,
                                  )),
                              child: OfferView(
                                name: userName,
                                surname: userSurname,
                                photoUrl: userPhoto,
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
                      stream: messagesCollection
                          .where('userrId', isEqualTo: userRole.user.details.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Text('No chats found.');
                        }
                        return Center(
                          child: SizedBox(
                            width: 333,
                            child: ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic>? userData =
                                    document.data() as Map<String, dynamic>?;
                                // String userId = document.id;
                                String userId = userData?['userrId'] ?? '';
                                String courierId = userData?['courierId'] ?? '';
                                String userName =
                                    userData?['courierName'] ?? '';
                                String userPhoto = userData?['userPhoto'] ?? '';
                                String courierPhoto =
                                    userData?['courierPhoto'] ?? '';

                                return GestureDetector(
                                  onTap: () => Get.to(() => ChatPage(
                                        groupId: userId,
                                        groupName: userName,
                                        userName: userRole.user.details.name,
                                        id: courierId,
                                        photo: courierPhoto,
                                      )),
                                  child: OfferView(
                                    name: userData?['courierName'],
                                    surname: userData?['courierName'],
                                    photoUrl: userPhoto,
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
                  : const Text('data'),
        ),
      );
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
