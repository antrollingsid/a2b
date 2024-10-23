import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/review.dart';
import '../../main/utils/colors.dart';
import '../chat/pages/chat_page.dart';
import '../createOrder/order_map.dart';
import '../dashboard/dashboard.dart';
import '../profile/profile.dart';
import 'ratePage/rate_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final String userId;

  const DetailsPage(this.userId, {super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  late String userName;

  @override
  void initState() {
    super.initState();
    fetchUserName(); // Fetch the userName when the state is initialized
  }

  void fetchUserName() async {
    final userDoc = await usersCollection.doc(user.uid).get();
    setState(() {
      userName = userDoc['details']['name'];
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData(String id) async {
    return FirebaseFirestore.instance.collection('users').doc(id).get();
  }

  // final String displayName = fetchData(user.uid);
  @override
  Widget build(BuildContext context) =>
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchData(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('No data available');
          } else {
            final data = snapshot.data!.data();

            return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: context.scaffoldBackgroundColor,
                body: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Implement the logic to show the image in full size
                                  // For example, you can use a Dialog or a separate screen to display the image.
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: Image.network(
                                        data['details']['photoURL'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipOval(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data!['details']['photoURL']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data['details']['name'],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    data['role'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 86,
                            width: 333,
                            decoration: BoxDecoration(
                                color: context.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ChatPage(
                                            userName: userName,
                                            groupId: widget.userId,
                                            groupName: data['details']['name'],
                                            photo: data['details']['photoURL'],
                                            id: data['details']['id'],
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width:
                                            40, // Adjust the width as per your desired size
                                        height:
                                            40, // Adjust the height as per your desired size
                                        child: ClipOval(
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                color: context
                                                    .primaryColor, // Add a background color to the container
                                                child: Center(
                                                  child: Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: context
                                                        .scaffoldBackgroundColor,
                                                    // Set the color of the phone icon
                                                  ),
                                                ))),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch("tel://+905488788211");
                                    print('you clicked me');
                                  },
                                  child: SizedBox(
                                    width:
                                        40, // Adjust the width as per your desired size
                                    height:
                                        40, // Adjust the height as per your desired size
                                    child: ClipOval(
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            color: context.primaryColor,
                                            child: Center(
                                              child: Icon(
                                                Icons.phone,
                                                color: context
                                                    .scaffoldBackgroundColor,
                                              ),
                                            ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 333,
                            height: 410,
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                CustomReview(
                                  id: widget.userId,
                                ),
                              ],
                            ),
                          ),
                          CustomBtn(
                            textonbtn: 'rate the courier',
                            onPress: () {
                              Get.to(() => RatePage(userId: widget.userId));
                            },
                            primary: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors
                            .backgroundLight, // Choose your desired color
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
                            color: AppColors.backgroundLight,
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
                          color: AppColors.backgroundLight,
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
          }
        },
      );
}
