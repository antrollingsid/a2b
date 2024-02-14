import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../main/utils/colors.dart';
import '../../createOrder/order_map.dart';
import '../../dashboard/dashboard.dart';
import '../../profile/profile.dart';
import 'controller/rate_conroller.dart';

class RatePage extends StatefulWidget {
  final String userId;

  const RatePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<RatePage> createState() => _RatePage();
}

final TextEditingController _commentController = TextEditingController();

class _RatePage extends State<RatePage> {
  double _rating = 3.0; // Variable to store the rating
  final user = FirebaseAuth.instance.currentUser!;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  late String userName;
  late String photoURL;
  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    final userDoc = await usersCollection.doc(user.uid).get();
    setState(() {
      userName = userDoc['details']['name'];
      photoURL = userDoc['details']['photoURL'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final rate = Get.put(RateController());
    return GetBuilder<AuthController>(builder: (controller) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.scaffoldBackgroundColor,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: CustomAppBar(
              titleText: 'rate and review',
              isActionVisible: true,
              isLeadingVisible: true,
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  Center(
                    child: SizedBox(
                      width: 333,
                      child: TextField(
                        controller: _commentController,
                        maxLines: null, // allow any number of lines
                        minLines: 5, // set a minimum of 5 lines
                        keyboardType: TextInputType
                            .multiline, // set the keyboard type to multiline
                        decoration: const InputDecoration(
                          hintText: 'Enter your text here', // add a hint text
                          border: OutlineInputBorder(),
                          filled: true, // enable filling of the TextField

                          fillColor:
                              Colors.white, // set the background color to white
                          // add a border
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 340,
                  ),
                  Center(
                    child: CustomBtn(
                      onPress: () => rate.rateCourier(
                        context,
                        controller.user.details.id,
                        widget.userId,
                        _rating.toString(),
                        _commentController.text,
                        userName,
                        photoURL,
                      ),
                      textonbtn: 'submit',
                      primary: true,
                    ),
                  ),

                  // CustomCalendar(),
                  // CustomShip(),
                ],
              ),
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
}
