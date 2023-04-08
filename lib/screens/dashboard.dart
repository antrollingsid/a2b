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
              // bottom: SearchBarTrackNo(),
            ),
          ),
          body: Center(
            child: Column(children: [
              Container(
                height: 90,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(4),
                // ),
                // color: AppColors.buttonRed,
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //     // colors: [AppColors.primaryDark, AppColors.secondary],
                    //     begin: const FractionalOffset(0.0, 0.0),
                    //     end: const FractionalOffset(0.5, 0.0),
                    //     stops: const [0.0, 1.0],
                    //     tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(10.0)),
                // color: AppColors.buttonRed,
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


// AppBar(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(30),
//                 ),
//               ),
//               elevation: 0,
//               backgroundColor: AppColors.primaryDark,
//               automaticallyImplyLeading: false,
//               title: Container(
//                 width: double.infinity,
//                 height: 40,
//                 color: Colors.transparent,
//                 child: const Center(child: SearchBarTrackNo()),
//               ),
//             ),