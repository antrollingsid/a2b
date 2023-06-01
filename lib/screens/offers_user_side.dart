import 'package:flutter/material.dart';
import '../../Components/widgets/offer_show.dart';
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLightMode,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'offers',
          isActionVisible: true,
          isLeadingVisible: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OfferView(
                name: '',
                photoUrl: '',
              ),
              OfferView(
                name: '',
                photoUrl: '',
              ),
              OfferView(
                name: '',
                photoUrl: '',
              ),
              OfferView(
                name: '',
                photoUrl: '',
              ),

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
