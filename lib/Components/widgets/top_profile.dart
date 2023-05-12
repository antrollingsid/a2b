import 'package:a2b/controllers/auth_controller.dart';
import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class TopProfile extends StatelessWidget {
  const TopProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return !controller.isLoggedIn
            ? Container()
            : Center(
                child: Container(
                  // color: AppColors.buttonBlue,
                  width: 333,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 60, 0),
                            child: Container(
                              width: 115,
                              height: 115,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 148, 34, 34),
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          controller.user.details.photoURL),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            height: 150,
                            child: VerticalDivider(
                              width: 3,
                              thickness: 2,
                              color: Color(0xff979797),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Joined',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                        // height:  1.5*ffem/fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                    Text(
                                      timeago
                                          .format(controller.user.createdAt,
                                              locale: 'en_short')
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        // height:  1.5*ffem/fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Wallet',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                        // height:  1.5*ffem/fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                    Text(
                                      "250",
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        // height:  1.5*ffem/fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.details.name,
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                // height:  1.5*ffem/fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.user.details.surname,
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 36,
                                fontWeight: FontWeight.w200,
                                // wordSpacing: 1.5,
                                letterSpacing: 1.5,
                                // height:  1.5*ffem/fem,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
