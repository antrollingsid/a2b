import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/chat/pages/chat_page.dart';
import '../../screens/userDetails/details.dart';
import '../assets/fonts.dart';

class ContactInfoDetails extends StatelessWidget {
  const ContactInfoDetails({
    super.key,
    required this.data,
    required this.userName,
    required this.widget,
  });

  final Map<String, dynamic>? data;
  final String userName;
  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data?['details']['name'],
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  data?['details']['surname'],
                  style: TextStyle(
                    fontFamily: AppFonts.mainFont,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              data?['role'],
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: 46,
          // width: 333,
          decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ChatPage(
                          userName: userName,
                          groupId: widget.userId,
                          groupName: data?['details']['name'],
                          photo: data?['details']['photoURL'],
                          id: data?['details']['id'],
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 40, // Adjust the width as per your desired size
                      height: 40, // Adjust the height as per your desired size
                      child: ClipOval(
                          child: Container(
                              height: 40,
                              width: 40,
                              color: context
                                  .primaryColor, // Add a background color to the container
                              child: Center(
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: context.scaffoldBackgroundColor,
                                  // Set the color of the phone icon
                                ),
                              ))),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  launch("tel://+905488788211");
                  print('you clicked me');
                },
                child: SizedBox(
                  width: 40, // Adjust the width as per your desired size
                  height: 40, // Adjust the height as per your desired size
                  child: ClipOval(
                      child: Container(
                          height: 40,
                          width: 40,
                          color: context.primaryColor,
                          child: Center(
                            child: Icon(
                              Icons.phone,
                              color: context.scaffoldBackgroundColor,
                            ),
                          ))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
