import 'package:a2b/Components/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Components/widgets/review.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';
import '../ratePage/rate_page.dart';

class DetailsPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const DetailsPage({Key? key});

  @override
  State<DetailsPage> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(227),
        child: DetailsAppBar(
          titleText: 'Courier Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'courier name',
                        style: TextStyle(
                          color: AppColors.backgroundLightMode,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'courier/user/admin',
                        style: TextStyle(
                          color: AppColors.backgroundLightMode,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.string(SvgConstant.callBtnDark)
                ],
              ),
              Container(
                height: 86,
                width: 333,
                color: AppColors.buttonBlue,
                child: const Row(
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
                    ]),
              ),
              const CustomReview(),
              CustomBtn(
                textonbtn: 'rate the courier',
                onPress: () {
                  Get.to(() => const RatePage());
                },
                primary: true,
              )
              // CustomCalendar(),
              // CustomShip(),
            ],
          ),
        ),
      ),
    );
  }
}
