import 'package:flutter/material.dart';

import '../assets/colors.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.textonbtn, required this.onPress});
  final String textonbtn;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(0),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              colors: [
                AppColors.secondary,
                AppColors.primaryDark,
              ],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(1.0, 0.4),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            textonbtn,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
