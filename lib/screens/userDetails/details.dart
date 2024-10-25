import 'package:a2b/Components/assets/fonts.dart';
import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/contact_info_details.dart';
import '../../Components/widgets/cover_image_details.dart';
import '../../Components/widgets/experience_details.dart';
import '../../Components/widgets/review.dart';
import '../../main.dart';
import '../../main/utils/colors.dart';
import '../../main/utils/widgets.dart';
import '../chat/pages/chat_page.dart';
import '../createOrder/order_map.dart';
import '../dashboard/dashboard.dart';
import '../profile/profile.dart';
import 'ratePage/rate_page.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../../Components/assets/fonts.dart';

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
              backgroundColor: appStore.isDarkMode
                  ? AppColors.backgroundDark
                  : AppColors.backgroundLight,
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CoverImageDetails(data: data),
                        stackContainerDetails(context),
                      ],
                    ),
                    SizedBox(
                      width: 333,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContactInfoDetails(
                              data: data, userName: userName, widget: widget),
                          const SizedBox(
                            height: 20,
                          ),
                          const ExperienceDetails(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 333,
                            height: 210,
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
                  ],
                ),
              ),
            );
          }
        },
      );
}
