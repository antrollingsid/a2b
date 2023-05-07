import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';

import '../assets/fonts.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.titleText,
    required this.isPassword,
    required this.hintText,
  });
  final String titleText;
  final bool isPassword;
  final String hintText;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _showIcon = true;
  bool _isFocused = true;
  bool _isPassword = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isPassword == false) {
      _isPassword = false;
    } else {
      _isPassword = true;
    }

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
          ElevatedButton(
            onPressed: () {
              setState(
                () {
                  _showIcon = !_showIcon;
                  _isPassword = !_isPassword;
                },
              );
            },
            child: const Text('Press me'),
          ),
          const SizedBox(height: 2),
          SizedBox(
            height: 67,
            width: 333,
            child: Center(
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    obscureText: _isPassword,
                    style: const TextStyle(
                      color: AppColors.backgroundLightMode,
                    ),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      // prefixIcon: SvgPicture.string(SvgConstant.checkBoxBtn),
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        color: AppColors.textGrey,
                      ),
                      filled: true,
                      fillColor: AppColors.buttonDark,
                      border: myinputborder(_showIcon),
                      enabledBorder: myinputborder(_showIcon), //enabled border
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  _isPassword
                      ? ClipRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: IconButton(
                            icon: SvgPicture.string(
                              _isFocused
                                  ? SvgConstant.eyeCloseDark
                                  : SvgConstant.eyeOpenDark,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  _isFocused = !_isFocused;
                                  // _showIcon = !_showIcon;
                                  _isPassword = !_isPassword;
                                },
                              );
                            },
                          ),
                        )
                      : _showIcon
                          ? IconButton(
                              icon: SvgPicture.string(SvgConstant.checkBoxBtn),
                              color: _isPassword
                                  ? Colors.white
                                  : null, // Set color white when isPassword is true
                              onPressed: () {},
                            )
                          : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

GradientOutlineInputBorder myinputborder(_showIcon) {
  if (_showIcon) {
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
