import 'package:flutter/material.dart';
import '../../Components/widgets/custom_button.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const RatePage({Key? key});

  @override
  State<RatePage> createState() => _RatePage();
}

class _RatePage extends State<RatePage> {
  RangeValues _currentRangeValues = const RangeValues(0, 80);
  @override
  void initState() {
    super.initState();
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'rate and review',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
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
                  print(rating);
                },
              ),
              const TextField(
                maxLines: null, // allow any number of lines
                minLines: 5, // set a minimum of 5 lines
                keyboardType: TextInputType
                    .multiline, // set the keyboard type to multiline
                decoration: InputDecoration(
                  hintText: 'Enter your text here', // add a hint text
                  border: OutlineInputBorder(),
                  filled: true, // enable filling of the TextField

                  fillColor: Colors.white, // set the background color to white
                  // add a border
                ),
              ),

              CustomBtn(
                onPress: () {},
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
  }
}
