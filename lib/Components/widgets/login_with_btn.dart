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
            textAlign: TextAlign.left,
            style: TextStyle(color: Colors.white, fontSize: 14),
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
                      height: 62,
                      // width: 158,
                      decoration: BoxDecoration(
                        color: AppColors.buttonDark,
                        borderRadius: BorderRadius.circular(
                          Dimensions.borderRadius8,
                        ),
                        border: Border.all(
                          color: AppColors
                              .buttonStroke, // specify the border color
                          width: 2.0, // specify the border width
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.string(
                          SvgConstant.googleLogo,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: Dimensions.loginWithBtnHeight,
                    decoration: BoxDecoration(
                      color: AppColors.buttonDark,
                      borderRadius: BorderRadius.circular(
                        Dimensions.borderRadius8,
                      ),
                      border: Border.all(
                        color:
                            AppColors.buttonStroke, // specify the border color
                        width: 2.0, // specify the border width
                      ),
                    ),
                    child: IconButton(
                      icon: SvgPicture.string(
                        SvgConstant.appleLogo,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
