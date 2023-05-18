import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main/utils/allConstants.dart';

class OrderHistoryActivity extends StatelessWidget {
  const OrderHistoryActivity({
    Key? key,
  }) : super(key: key);

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
                        decoration: BoxDecoration(
                          color: AppColors.buttonDark,
                          borderRadius: BorderRadius.circular(50),
                        ),
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
                            const Text(
                              'iPhone Head Charger',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                // height:  1.5*ffem/fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 5, 6.75, 0),
                                  child: SvgPicture.string(
                                      SvgConstant.dotInCircle),
                                ),
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Order',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1,
                                          color: Color(0xffcf6679),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ',
                                      ),
                                      TextSpan(
                                        text: '- 27 May, 2022',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 2,
                                          color: Color(0xff979797),
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: const Text(
                          'Received',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            // height:  2*ffem/fem,
                            color: Color(0xffffffff),
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
