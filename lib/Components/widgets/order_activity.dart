import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main/utils/allConstants.dart';

class OrderHistoryActivity extends StatelessWidget {
  const OrderHistoryActivity({
    super.key,
    required this.productName,
    required this.status,
    required this.date,
  });
  final String productName;
  final String status;
  final String date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  height: 60,
                  // color: const Color.fromARGB(255, 81, 2, 90),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 9),
                        // decoration: BoxDecoration(
                        //   color: AppColors.buttonDark,
                        //   borderRadius: BorderRadius.circular(50),
                        // ),
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          child: SvgPicture.string(
                            SvgConstant.parcelIconDark,
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                        width: 162,
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                // height:  1.5*ffem/fem,
                                // color: Color(0xffffffff),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 5, 6.75, 0),
                                  child: SvgPicture.string(
                                      SvgConstant.dotInCircle,
                                      color: context.primaryColor),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Order',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1,
                                          color: context.primaryColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: '- $date',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 2,
                                          color: context.hintColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 9, 2.5),
                        child: SvgPicture.string(
                          SvgConstant.tickIconDark,
                          width: 17,
                          height: 17,
                          color: context.primaryColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            // height:  2*ffem/fem,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
