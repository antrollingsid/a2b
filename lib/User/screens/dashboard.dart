import 'package:a2b/Components/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/widgets/custom_textfield_gradiant.dart';
import '../../Components/widgets/offer_detail.dart';
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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                    height: 96,
                    // color: const Color.fromARGB(255, 81, 2, 90),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // color: AppColors.buttonRed,
                          margin: const EdgeInsets.fromLTRB(0, 0, 23, 1),
                          child: SvgPicture.string(
                              // ignore: prefer_interpolation_to_compose_strings
                              '<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">'
                                      '<path d="M15.125 8.61666L6.875 3.85916" stroke="#CF6679" stroke-linecap="round" stroke-linejoin="round"/>' +
                                  '<path d="M19.25 14.6667V7.33334C19.2497 7.01184 19.1648 6.69608 19.0039 6.41774C18.843 6.1394 18.6118 5.90826 18.3333 5.74751L11.9167 2.08084C11.638 1.91993 11.3218 1.83522 11 1.83522C10.6782 1.83522 10.362 1.91993 10.0833 2.08084L3.66667 5.74751C3.38824 5.90826 3.15698 6.1394 2.99609 6.41774C2.8352 6.69608 2.75033 7.01184 2.75 7.33334V14.6667C2.75033 14.9882 2.8352 15.3039 2.99609 15.5823C3.15698 15.8606 3.38824 16.0918 3.66667 16.2525L10.0833 19.9192C10.362 20.0801 10.6782 20.1648 11 20.1648C11.3218 20.1648 11.638 20.0801 11.9167 19.9192L18.3333 16.2525C18.6118 16.0918 18.843 15.8606 19.0039 15.5823C19.1648 15.3039 19.2497 14.9882 19.25 14.6667Z" stroke="#CF6679" stroke-linecap="round" stroke-linejoin="round"/>' +
                                  '<path d="M2.99756 6.38L11.0001 11.0092L19.0026 6.38" stroke="#CF6679" stroke-linecap="round" stroke-linejoin="round"/>' +
                                  '<path d="M11 20.24V11" stroke="#CF6679" stroke-linecap="round" stroke-linejoin="round"/>' +
                                  '</svg>'),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 60, 0),
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
                              Container(
                                // margin:
                                //     const EdgeInsets.fromLTRB(0.75, 0, 26, 0),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 6.75, 0),
                                      // child: Image.asset(
                                      //   'assets/images/1x/Artboard14.png',
                                      //   width: 7.5,
                                      //   height: 7.5,
                                      // ),
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
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 9, 2.5),
                          child: SvgPicture.string(
                            '<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10 3L4.5 8.5L2 6" stroke="#60BFF4" stroke-linecap="round" stroke-linejoin="round"/></svg>',
                            // width: 8,
                            // height: 5.5,
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
      ),
    );
  }
}
