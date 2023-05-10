import 'package:a2b/Components/widgets/message.dart';
import 'package:flutter/material.dart';
import '../../Components/widgets/offer_detail.dart';
import '../../Components/widgets/offer_show.dart';
import '../../Components/widgets/order_activity.dart';
import '../../Components/widgets/review.dart';
import '../../Components/widgets/settings_button.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class CourierOffers extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CourierOffers({Key? key});

  @override
  State<CourierOffers> createState() => _CourierOffers();
}

class _CourierOffers extends State<CourierOffers> {
  @override
  void initState() {
    super.initState();
  }

  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'offers',
          isActionVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              OfferView(),
              OfferView(),
              OfferView(),
              OfferView(),
              OfferView(),
              OfferView(),
              OfferView(),
              // Message(),
              // CustomReview(),
              // OfferDetail(),
              // OrderHistoryActivity(),
            ],
          ),
        ),
      ),
    );
  }
}
