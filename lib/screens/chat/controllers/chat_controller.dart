import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chats =
      FirebaseFirestore.instance.collection('chats');

  // saving the userdata
  // Future savingUserData(String fullName, String email, String userId, String courierId) async {
  //   final createdAt = DateTime.now();
  //   return chats.doc().set(
  //     {
  //       'createdAt': createdAt,
  //       'userId': userId,
  //       'courierId': courierId,
  //       'packageDetails': {
  //         'productName': package_name,
  //         'weight': package_weight,
  //         'productType': package_type,
  //         'fragile': IsFragile,
  //         'productUrl': urlDownload,
  //       },
  //       'locationDetaills': {
  //         'pickupAddress': pickup_address,
  //         'pickupLatitude': pickupLatitude,
  //         'pickupLongitude': pickupLongitude,
  //         'deliveryAddress': delivery_address,
  //         'deliveryLatitude': deliveryLatitude,
  //         'deliveryLongitude': deliveryLongitude,
  //       },
  //       'deliveryDetails': {
  //         'deliveryDate': delivery_date,
  //         'sendedBy': user.uid,
  //         'deliverBy': courrier_id,
  //         'duration': delivery_duration,
  //       },
  //       'price': 0.0,
  //       'description': description,
  //     },
  //   );
  //   return await userCollection.doc(uid).set({
  //     "groups": [],
  //     "uid": uid,
  //   });
  // }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await chats.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "sid",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  // getting the chats
  getChats(String groupId) async {
    return chats
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = chats.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupId) async {
    return chats.doc(groupId).snapshots();
  }

  // search
  searchByName(String groupName) {
    return chats.where("groupName", isEqualTo: groupName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = chats.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    chats.doc(groupId).collection("messages").add(chatMessageData);
    chats.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
