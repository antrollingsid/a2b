import 'package:a2b/screens/livemap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../controllers/auth_controller.dart';
import '../../main/utils/allConstants.dart';

class CustomShip extends StatelessWidget {
  const CustomShip({super.key});

  @override
  Widget build(BuildContext context) {
    final tracked = FirebaseFirestore.instance.collection('location');
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            height: 143,
            width: 333,
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Track\nYour Shipping',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: SvgPicture.string(SvgConstant.parcelIconBlack),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(6, 10, 0, 0),
                          child: Text(
                            "Iphone 12",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textBlack,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )),
                Container(
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: MyMap1(
                      tracked.doc('user1').id,
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
