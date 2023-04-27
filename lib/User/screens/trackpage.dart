import 'package:a2b/Components/assets/colors.dart';
import 'package:flutter/material.dart';

import '../../Components/widgets/custom_textfield_gradiant.dart';
import '../../Components/widgets/offer_detail.dart';
import '../../Components/widgets/shippement.dart';

class TrackShippement extends StatelessWidget {
  const TrackShippement({super.key});

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
                  // const CustomShip(),
                  // Container(
                  //   margin: const EdgeInsets.fromLTRB(0, 0, 211, 22),
                  //   child: RichText(
                  //     text: const TextSpan(
                  //       style: TextStyle(
                  //         fontFamily: 'SF Pro Display',
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w400,
                  //         // height: 1.3333333333 * ffem / fem,
                  //         letterSpacing: 1.5,
                  //         color: Color(0xffffffff),
                  //       ),
                  //       children: [
                  //         TextSpan(
                  //           text: 'Latest ',
                  //         ),
                  //         TextSpan(
                  //           text: 'activities',
                  //           style: TextStyle(
                  //             fontFamily: 'SF Pro Display',
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w400,
                  //             // height: 1.3333333333 * ffem / fem,
                  //             letterSpacing: 1.5,
                  //             color: Color(0xff979797),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                    height: 96,
                    color: Color.fromARGB(255, 81, 2, 90),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // height: 10,
                          margin: const EdgeInsets.fromLTRB(0, 0, 23, 1),
                          child: Image.asset(
                            'assets/images/1x/Artboard14.png',
                            width: 47,
                            height: 47,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 56, 0),
                          width: 142,
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'iPhone Head Charger',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  // height:  1.5*ffem/fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(0.75, 0, 26, 0),
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
                                              fontSize: 8,
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
                                              fontSize: 8,
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
                          //TICK ICON
                          margin: const EdgeInsets.fromLTRB(0, 0, 6, 2.5),
                          // child: Image.asset(
                          //   'assets/images/1x/Artboard14.png',
                          //   width: 8,
                          //   height: 5.5,
                          // ),
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
            // const SizedBox(
            //   height: 5,
            // ),
            // const GradiantTextfield(
            //   hintText: 'Text',
            //   titleText: '',
            // )
          ],
        ),
      ),
    );
  }
}
