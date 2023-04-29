import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../assets/colors.dart';
import '../assets/fonts.dart';

class GradiantTextfield extends StatefulWidget {
  const GradiantTextfield({
    super.key,
    required this.titleText,
    this.isPassword = false,
    required this.hintText,
  });
  final String titleText;

  final bool isPassword;
  final String hintText;

  @override
  State<GradiantTextfield> createState() => _GradiantTextfieldState();
}

class _GradiantTextfieldState extends State<GradiantTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                widget.titleText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: 67,
            width: 333,
            child: TextField(
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: widget.hintText, // pass the hint text parameter here
                hintStyle: TextStyle(
                  fontFamily: AppFonts.mainFont,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onBackgroundDark,
                ),
                border: GradientOutlineInputBorder(
                    gradient: const LinearGradient(
                        colors: [AppColors.primaryDark, AppColors.secondary],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    width: 2,
                    borderRadius: BorderRadius.circular(10.0)),

                focusedBorder: GradientOutlineInputBorder(
                    gradient: const LinearGradient(
                        colors: [
                          AppColors.secondary,
                          AppColors.primaryDark,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    width: 2,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 181, 181, 181)),
            ),
          ),
        ],
      ),
    );
  }
}
