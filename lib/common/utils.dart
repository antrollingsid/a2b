import 'dart:ui';

import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';

// import '../../../theme.dart';

// Snackbar
void showSnackBar(BuildContext context, String message) {
  final brightness = Theme.of(context).brightness;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: (brightness == Brightness.light)
          ? AppColors.buttonBlue
          : AppColors.buttonYellow,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 15,
          color: (brightness != Brightness.light)
              ? AppColors.textBlue
              : AppColors.textGrey,
        ),
      ),
    ),
  );
}
// End

// logout Alert dialog
void showAlertDialog(
  BuildContext context,
  String content,
  String actionTitle,
  VoidCallback onActionButtonTap,
) {
  final brightness = Theme.of(context).brightness;
  showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: AlertDialog(
          content: Text(content),
          contentPadding: const EdgeInsets.all(30),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          buttonPadding: const EdgeInsets.all(15),
          contentTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 12)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    brightness == Brightness.light
                        ? AppColors.customIconButtonBackgroundLight
                        : AppColors.customIconButtonBackgroundDark),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancle"),
            ),
            TextButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              onPressed: onActionButtonTap,
              child: Text(actionTitle),
            ),
          ],
        ),
      );
    },
  );
}

// popup menu
void showHomePagePopUpMenu(BuildContext context, Offset offset,
    List<PopupMenuEntry<dynamic>> items) async {
  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    context: context,
    position: RelativeRect.fromDirectional(
        textDirection: Directionality.of(context),
        start: left,
        top: top,
        end: left + 2,
        bottom: top + 2),
    items: items,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
  );
}

// popup menu
void showChatScreenPopUpMenu(BuildContext context, Offset offset,
    List<PopupMenuEntry<dynamic>> items) async {
  double left = offset.dx;
  double top = offset.dy;
  await showMenu(
    context: context,
    position: RelativeRect.fromDirectional(
        textDirection: Directionality.of(context),
        start: left,
        top: top,
        end: left + 2,
        bottom: top + 2),
    items: items,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
  );
}

// Bottom Sheet
void showCustomBottomSheet(
  BuildContext context,
  Widget child,
  double InitialChildSize,
  double maxChildSize,
) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: InitialChildSize,
        minChildSize: 0.1,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: child,
          );
        },
      );
    },
  );
}
