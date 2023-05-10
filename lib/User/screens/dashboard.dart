// ignore_for_file: unnecessary_import

import 'package:a2b/User/screens/place_order_upload.dart';
import 'package:a2b/User/screens/profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Components/widgets/custom_botton_nav.dart';
import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';
import 'epmty_page_appar.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'dashboard',
        ),
      ),
      body: SingleChildScrollView(
        child: FittedBox(
          child: Column(
            children: [
              const CustomShip(),
              const TrackingTextField(),
              const OrderHistoryActivity(),
              const OrderHistoryActivity(),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: SvgPicture.string(SvgConstant.lineDark),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const EmptyPage());
                },
                child: const Text('Empty Page'),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: appStore.availableBal >= 0
      //       ? AppColors.primaryDark
      //       : AppColors.buttonRed,
      //   child: const Icon(
      //     Icons.add,
      //     color: AppColors.backgroundDark,
      //   ),
      //   onPressed: () {
      //     const PlaceOrderMap().launch(
      //       context,
      //       pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
      //     );
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNav(
        actionitem1: () => Get.to(const PlaceOrderUpload()),
        actionitem2: () {},
        actionitem3: () {},
        actionitem4: () {},
        actionitem5: () => Get.to(const Profile()),
      ),
    );
  }
}

class TrackingTextField extends StatelessWidget {
  const TrackingTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: Center(
          child: TextField(
            style: const TextStyle(color: AppColors.backgroundLightMode),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.string(
                  SvgConstant.searchIconDark,
                  width: 19,
                  height: 19,
                ),
              ),
              hintText: 'Tracking code',
              hintStyle: const TextStyle(color: AppColors.textGrey),
              filled: true,
              fillColor: AppColors.buttonStroke,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(
                    colors: [AppColors.secondaryBlue, AppColors.primaryDark],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.5, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                width: 1,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
