// ignore_for_file: deprecated_member_use

import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.titleText,
    required this.isPassword,
    required this.hintText,
    required this.mycontroller,
  });
  final String titleText;
  final bool isPassword;
  final String hintText;
  final TextEditingController mycontroller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  final bool _showIcon = true;
  late bool _isPassword;
  late bool _obscured;
  late String hintText;
  late String titleText;

  @override
  void initState() {
    _isPassword = widget.isPassword;
    hintText = widget.hintText;
    titleText = widget.titleText;
    _obscured = widget.isPassword;
    super.initState();
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

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
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text(
                widget.titleText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     setState(
          //       () {
          //         _showIcon = !_showIcon;
          //         _isPassword = !_isPassword;
          //       },
          //     );
          //   },
          //   child: const Text('Press me'),
          // ),
          const SizedBox(height: 2),
          SizedBox(
            height: 67,
            width: 333,
            child: Center(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: widget.mycontroller,
                    obscureText: _obscured,
                    style: const TextStyle(
                      color: AppColors.backgroundLightMode,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      // prefixIcon: SvgPicture.string(SvgConstant.checkBoxBtn),
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.textGrey,
                      ),
                      filled: true,
                      fillColor: AppColors.buttonDark,
                      border: myinputborder(_showIcon),
                      enabledBorder: myinputborder(_showIcon), //enabled border
                      focusedBorder: myfocusborder(),

                      suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: _isPassword
                              ? GestureDetector(
                                  onTap: _toggleObscured,
                                  child: Icon(
                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 18,
                                      color: Colors.white))
                              : IconButton(
                                  icon: SvgPicture.string(
                                      SvgConstant.checkBoxBtn),
                                  color: _isPassword
                                      ? Colors.white
                                      : null, // Set color white when isPassword is true
                                  onPressed: () {},
                                )),
                    ),
                  ),
                  // if (_isPassword)
                  //   ClipRect(
                  //     clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     child: IconButton(
                  //       icon: SvgPicture.string(
                  //         _isFocused
                  //             ? SvgConstant.eyeCloseDark
                  //             : SvgConstant.eyeOpenDark,
                  //         color: Colors.white,
                  //       ),
                  //       onPressed: _toggleObscured,
                  //     ),
                  //   )
                  // else
                  //   _showIcon
                  //       ? IconButton(
                  //           icon: SvgPicture.string(SvgConstant.checkBoxBtn),
                  //           color: _isPassword
                  //               ? Colors.white
                  //               : null, // Set color white when isPassword is true
                  //           onPressed: () {},
                  //         )
                  //       : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

GradientOutlineInputBorder myinputborder(showIcon) {
  if (showIcon) {
    return const GradientOutlineInputBorder(
      gradient: LinearGradient(
        colors: [
          AppColors.secondaryBlue,
          AppColors.primaryDark,
        ],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(0.5, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      width: 1.0,
    );
  } else {
    return const GradientOutlineInputBorder(
      gradient: LinearGradient(
        colors: [
          AppColors.buttonStroke,
          AppColors.buttonStroke,
        ],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(0.5, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      width: 1.0,
    );
  }
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: AppColors.buttonStroke,
        width: 2,
      ));
}
