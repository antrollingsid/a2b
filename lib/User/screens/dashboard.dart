import 'package:a2b/Components/assets/colors.dart';
import 'package:a2b/allConstants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';

import '../../Components/widgets/custom_textfield_gradiant.dart';
import '../../Components/widgets/offer_detail.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/shippement.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      ),
      body: Column(
        children: [
          const CustomShip(),
          const TrackingTextField(),
          const OrderHistoryActivity(),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: SvgPicture.string(SvgConstant.lineDark),
          ),
        ],
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
    return const Padding(
      padding: EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: GradientOutlineInputBorder(
              gradient: LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.secondary],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              width: 1,
              // borderRadius: BorderRadius.circular(Dimensions.dimen_10),
            ),
          ),
        ),
      ),
    );
  }
}
