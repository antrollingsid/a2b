import 'package:flutter/material.dart';

// import '../../profile/profile_screen.dart';

class ChatScreenPopUpMenu extends StatelessWidget {
  const ChatScreenPopUpMenu({super.key, required this.items, this.icon});

  final List<PopupMenuEntry> items;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: ((context) => items),
      offset: const Offset(-15, 40),
      splashRadius: 18,
      elevation: 8,
      icon: icon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      onSelected: (value) {
        if (value == "profile") {
          // Navigator.of(context).push(UserProfile.route());
        }
      },
    );
  }
}
