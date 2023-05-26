import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        margin: const EdgeInsets.all(0),
        width: 333,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: context.primaryColor,
            width: 1,
          ),
          color:
              primary ? context.primaryColor : context.scaffoldBackgroundColor,
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            textonbtn,
            style: TextStyle(
              color: primary
                  ? context.scaffoldBackgroundColor
                  : context.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
