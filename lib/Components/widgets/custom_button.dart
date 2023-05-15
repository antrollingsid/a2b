import 'package:flutter/material.dart';
import '../../main/utils/colors.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {Key? key,
      required this.textonbtn,
      required this.onPress,
      required this.primary})
      : super(key: key);

  final String textonbtn;
  final GestureTapCallback onPress;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: const EdgeInsets.all(0),
        width: 333,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
          color: primary ? AppColors.primary : AppColors.background,
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            textonbtn,
            style: TextStyle(
              color: primary ? AppColors.background : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
