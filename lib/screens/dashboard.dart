import 'package:flutter/material.dart';
import 'package:a2b/screens/colors.dart';

import 'elements.dart';
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
        // theme: ThemeData(
        //   primaryColor: AppColors.primaryDark,
        // ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.backgroundDark,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(293.0),
            child: AppBar(
              backgroundColor: AppColors.primaryDark,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(44),
                ),
              ),
              // bottom: ,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.transparent,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // TextFieldEmail(),
                    // TextFieldPassword(),
                    // PaddingTop90(),
                    // SearchBarTrackNo(),
                    // LoginButton(),
                    // InkWellSignUp(),
                  ],
                ),
              ),

              elevation: 0,
            ),
          ),
          body: Center(
            child: Column(children: [
              Container(
                height: 90,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: const SearchBarTrackNo(),
              ),
              Container(
                color: AppColors.buttonYellow,
                child: Text(
                  'This is the home page',
                  style: TextStyle(
                      fontSize: 24, color: AppColors.onBackgroundDark),
                ),
              ),
            ]),
          ),
        ));
  }
}
