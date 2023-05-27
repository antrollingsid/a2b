// ignore_for_file: deprecated_member_use

import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.isPassword,
    required this.hintText,
    required this.mycontroller,
    required this.width,
  });
  final bool isPassword;
  final String hintText;
  final TextEditingController mycontroller;
  final double width;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _isPassword;
  late bool _obscured;
  late String hintText;
  late String titleText;

  @override
  void initState() {
    _isPassword = widget.isPassword;
    hintText = widget.hintText;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 52,
          width: widget.width,
          child: Center(
            child: Stack(
              children: [
                TextField(
                  controller: widget.mycontroller,
                  obscureText: _obscured,
                  // style: const TextStyle(
                  //   color: Colors.black,
                  // ),
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: AppColors.textGrey,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: myinputborder(context),
                    enabledBorder: myinputborder(context), //enabled border
                    focusedBorder: myFocusBorder(context),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: _isPassword
                          ? GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                  _obscured
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 18,
                                  color: context.primaryColor))
                          : const SizedBox(
                              height: 0,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

OutlineInputBorder myinputborder(BuildContext context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 1,
      ));
}

OutlineInputBorder myFocusBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(5),
    ),
    borderSide: BorderSide(
      color: Theme.of(context).primaryColor,
      width: 1,
    ),
  );
}
