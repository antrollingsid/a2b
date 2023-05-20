// ignore_for_file: unnecessary_import

import 'package:a2b/screens/liveTracking/tracking_page.dart';
import 'package:a2b/screens/userDetails/details.dart';
import 'package:nb_utils/nb_utils.dart';

import '/screens/profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import '../../Components/widgets/app_bar_buttons.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';
import 'createOrder/new_order.dart';
import 'createOrder/order_details.dart';
import 'demo_page.dart';
import 'epmty_page_appar.dart';
import 'mymap.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            titleText: 'Dashboard',
            isActionVisible: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ship Your",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          // height:  1.5*ffem/fem,
                          // color: Color(0xffffffff),
                        ),
                      ),
                      Text(
                        'Package Safely',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          // wordSpacing: 1.5,
                          // letterSpacing: 1.5,
                          // height:  1.5*ffem/fem,
                          // color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
                const TrackingTextField(),
                const SizedBox(
                  height: 30,
                ),
                const CustomShip(),
                const SizedBox(
                  height: 30,
                ),
                // const OrderHistoryActivity(),
                SvgPicture.string(SvgConstant.lineDark),
                const OrderHistoryActivity(),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const DetailsPage());
                  },
                  child: const Text('detail Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const EmptyPage());
                  },
                  child: const Text('empty Page'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => MyApp());
                  },
                  child: const Text('track page 2'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const LiveTracking());
                  },
                  child: const Text('live trackin page'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: context.scaffoldBackgroundColor,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'hhh',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                  color: AppColors.backgroundLightMode,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            AppColors.secondaryBlue,
                            AppColors.primary,
                          ],
                          begin: FractionalOffset(0.0, 1.0),
                          end: FractionalOffset(1.0, 0.4),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.backgroundLightMode,
                    size: 40,
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.feedback_outlined,
                  color: AppColors.backgroundLightMode,
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
            // currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primary,
            onTap: (index) {
              if (index == 0) {
                Get.to(() => const DashBoard());
              } else if (index == 1) {
                Get.to(() => const DashBoard());
              } else if (index == 2) {
                Get.to(() => const NewOrder());
              } else if (index == 3) {
              } else if (index == 4) {
                Get.to(() => const Profile());
              }
            },
          ),
        ));
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
              fillColor: context.scaffoldBackgroundColor,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(
                    colors: [
                      AppColors.secondaryBlue,
                      AppColors.primary,
                    ],
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
