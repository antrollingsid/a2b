import 'package:flutter_svg/svg.dart';

import '../../main/utils/allConstants.dart';
import 'package:flutter/material.dart';

class LoginWithBtn extends StatelessWidget {
  const LoginWithBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Login with one the following options",
            style: TextStyle(
              fontFamily: 'Material Icons',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 333,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 52,
                      // width: 158,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        border: Border.all(
                          color: AppColors.primary, // specify the border color
                          width: 1.0, // specify the border width
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.string(
                          SvgConstant.googleLogo,
                          color: AppColors.primary,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      border: Border.all(
                        color: AppColors.primary, // specify the border color
                        width: 1.0, // specify the border width
                      ),
                    ),
                    child: IconButton(
                      icon: SvgPicture.string(
                        SvgConstant.appleLogo,
                        color: AppColors.primary,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
