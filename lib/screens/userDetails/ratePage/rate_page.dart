import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../Components/widgets/custom_button.dart';
import '../../../controllers/auth_controller.dart';
import '../../../main/utils/allConstants.dart';
import '../../../Components/widgets/app_bar_buttons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  RangeValues _currentRangeValues = const RangeValues(0, 80);
  @override
  void initState() {
    super.initState();
  }

  final int _selectedIndex = 0;

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TextField(
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

                CustomBtn(
                  onPress: () => rate.rateCourier(
                    context,
                    controller.user.details.id,
                    widget.userId,
                    _rating.toString(),
                    _commentController.text,
                  ),
                  textonbtn: 'submit',
                  primary: true,
                ),

                // CustomCalendar(),
                // CustomShip(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.buttonStroke,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
                color: AppColors.backgroundLightMode,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: AppColors.backgroundLightMode,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.feedback_outlined,
                color: AppColors.backgroundLightMode,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outlined,
                color: AppColors.backgroundLightMode,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primary,
          onTap: (index) {
            if (index == 2) {
              // Get.to(() => const RatePage());
            }
          },
        ),
      );
    });
  }
}
