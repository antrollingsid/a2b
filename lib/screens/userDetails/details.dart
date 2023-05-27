import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/review.dart';
import '../../main/utils/allConstants.dart';
import 'ratePage/rate_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  final String userId;

  DetailsPage(this.userId);

  // get data => fetchData(userId);

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData(String id) async {
    return FirebaseFirestore.instance.collection('users').doc(id).get();
  }

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
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
                            GestureDetector(
                              onTap: () {
                                launch(
                                    'tel:+905488788211'); // Replace the phone number with your desired phone number
                              },
                              child: Container(
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
                                            Icons.phone,
                                            color:
                                                context.scaffoldBackgroundColor,
                                            // Set the color of the phone icon
                                          ),
                                        ))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 86,
                          width: 333,
                          decoration: BoxDecoration(
                              color: context.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '6y',
                                    style: TextStyle(
                                      color: AppColors.backgroundLightMode,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('experience'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '6y',
                                    style: TextStyle(
                                      color: AppColors.backgroundLightMode,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('experience'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '6y',
                                    style: TextStyle(
                                      color: AppColors.backgroundLightMode,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('experience'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 333,
                          height:
                              480, // Adjust the height as per your requirements
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: [
                              CustomReview(),
                              CustomReview(),
                              CustomReview(),
                              CustomReview(),
                              // Add more CustomReview widgets as needed
                            ],
                          ),
                        ),
                        CustomBtn(
                          textonbtn: 'rate the courier',
                          onPress: () {
                            Get.to(
                                () => RatePage(userId: data!['details']['id']));
                          },
                          primary: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
}
