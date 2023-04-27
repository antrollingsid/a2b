import 'package:a2b/Components/assets/colors.dart';
import 'package:a2b/allConstants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        children: const [
          CustomShip(),
          OrderHistoryActivity(),
        ],
      ),
    );
  }
}
