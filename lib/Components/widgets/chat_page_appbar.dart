import 'package:a2b/main/utils/colors.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/avatar.dart';
// import '../../screens.dart';
import '../../screens/profile/profile_screen.dart';
import 'appbar_popup.dart';

class ChatScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  // final User user;
  const ChatScreenAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        // statusBarIconBrightness: (brightness != Brightness.light)
        //     ? Brightness.light
        //     : Brightness.dark,
        // statusBarBrightness: (brightness == Brightness.light)
        //     ? Brightness.light
        //     : Brightness.dark,
      ),
      elevation: 0,
      backgroundColor: AppColors.backgroundLightMode,
      automaticallyImplyLeading: false,
      // leading: backBtn(),
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            right: 6,
          ),
          child: Row(
            children: <Widget>[
              // Back button
              IconButton(
                splashRadius: 18.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.backgroundLightMode,
                ),
              ),
              // User profile button
              IconButton(
                padding: const EdgeInsets.all(0),
                splashRadius: 18.0,
                // Open container for opening and closing animations
                icon: OpenContainer(
                  openElevation: 0,
                  closedElevation: 0,
                  openShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (BuildContext context,
                          void Function({Object? returnValue}) action) =>
                      const UserProfile(),
                  closedBuilder: (context, VoidCallback openContainer) =>
                      Avatar(
                    radius: 21,
                    // url: user.profilePicture,
                    onTap: openContainer,
                  ),
                ),
                onPressed: () {},
              ),
              // Animation End
              const SizedBox(
                width: 12,
              ),
              // Name and Online status
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'user.name',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    // TODO: have to implement online status
                    Text(
                      "Online",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Call and video button
              // IconButton(
              //     splashRadius: 18.0,
              //     onPressed: () {},
              //     icon: const Icon(Icons.video_call_rounded)),
              // IconButton(
              //     splashRadius: 18.0,
              //     onPressed: () {},
              //     icon: const Icon(Icons.call)),
              // more button
              const ChatScreenPopUpMenu(
                items: [
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 5,
                      right: 10,
                    ),
                    value: "profile",
                    child: Text("View public profile"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "search",
                    child: Text("Search"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "media",
                    child: Text("Media"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "wallpaper",
                    child: Text("Wallpaper"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "mute",
                    child: Text("Mute Notifications"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "shortcut",
                    child: Text("Add Shortcut"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "block",
                    child: Text("Block"),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                      left: 30,
                      bottom: 3,
                      top: 3,
                      right: 5,
                    ),
                    value: "clear",
                    child: Text("Clear chat"),
                  ),
                ],
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.backgroundLightMode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
