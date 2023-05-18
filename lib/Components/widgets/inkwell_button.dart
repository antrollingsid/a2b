import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class InkwellBtn extends StatelessWidget {
  const InkwellBtn(
      {super.key,
      required this.textLeading,
      required this.textEnding,
      required this.onTap});
  final String textLeading;
  final String textEnding;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: textLeading,
            style: TextStyle(
              color: IconTheme.of(context).color,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: textEnding,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
