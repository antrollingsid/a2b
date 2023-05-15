import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';

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
            style: const TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: textEnding,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
