import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Components/widgets/review.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../ratePage/rate_page.dart';

class DetailsPage extends StatelessWidget {
  final String userId;

  DetailsPage(this.userId);

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData(String id) async {
    return FirebaseFirestore.instance.collection('users').doc(id).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(227),
        child: DetailsAppBar(
          titleText: 'Courier Details',
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
            final name = data!['name'];
            final otherData = data['otherData'];

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.string(SvgConstant.callBtnDark),
                      ],
                    ),
                    Container(
                      height: 86,
                      width: 333,
                      color: AppColors.buttonBlue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    CustomReview(),
                    CustomBtn(
                      textonbtn: 'rate the courier',
                      onPress: () {
                        Get.to(() => const RatePage());
                      },
                      primary: true,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
