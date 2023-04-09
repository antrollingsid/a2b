import 'package:flutter/material.dart';
import 'package:a2b/screens/colors.dart';

import 'buttons.dart';
import 'elements.dart';
import 'formWidgets.dart';
import 'paddings.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.backgroundDark,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: SizedBox(
              height: 100,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    backBtn(),
                    menuBtn(),
                    // TextFieldPassword(),
                    // PaddingTop90(),
                    // SearchBarTrackNo(),
                    // LoginButton(),
                    // InkWellSignUp(),
                  ],
                ),
              ),
            ),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Column(children: [
                menuBtn(),
                Container(
                  height: 160,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                  child: const SearchBarTrackNo(),
                ),
                Container(
                  color: AppColors.secondary,
                  child: Text(
                    'This is the home page',
                    style: TextStyle(
                        fontSize: 24, color: AppColors.onBackgroundDark),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
