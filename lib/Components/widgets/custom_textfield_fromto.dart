import 'package:flutter/material.dart';

import '../../main/utils/allConstants.dart';

class FromToTextField extends StatelessWidget {
  const FromToTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.type,
  });
  final String titleText;
  final String type;
  final String hintText;

// Color? color;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (type == 'from') {
      color = AppColors.primaryLight;
    } else if (type == 'to') {
      color = AppColors.secondaryDark;
    } else {
      color = AppColors
          .backgroundLight; // optional: handle cases where type is neither 'from' nor 'to'
    }
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        height: 67,
        width: 333,
        child: Center(
          child: TextField(
            style: const TextStyle(color: AppColors.backgroundLight),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  width: 131,
                  height: 61,
                  color: color,
                  child: Text(
                    titleText,
                  ),
                ),
              ),
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textGrey),
              filled: true,
              fillColor: AppColors.buttonStroke,
              border: myinputborder(),
              enabledBorder: myinputborder(), //enabled border
              focusedBorder: myfocusborder(),
            ),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: AppColors.buttonStroke,
        width: 2,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: AppColors.buttonStroke,
        width: 2,
      ));
}
