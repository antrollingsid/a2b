import 'package:a2b/main/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:heyy/screens/chat/widgets/message_info.dart';

import '../../Components/widgets/bottom_input_field.dart';
import '../../Components/widgets/message_datelable.dart';
import '../../Components/widgets/message_info.dart';
import '../../Components/widgets/message_tile.dart';
import '../../common/common.dart';
// import '../../models/user.dart';
import 'constants/constants.dart';
// import 'widgets/bottom_input_field.dart';
// import 'widgets/message_datelable.dart';
// import 'widgets/message_tile.dart';

class ChatScreen extends ConsumerStatefulWidget {
  // final User userConversation;
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  // this is for navigation
  static Route route() => MaterialPageRoute(
        builder: (context) => const ChatScreen(
            // userConversation: data,
            ),
      );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final bottomTextFeildController = TextEditingController();
  final bottomTextFeildFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    bottomTextFeildController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: AppColors.backgroundLightMode,
      appBar: const ChatScreenAppbar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Message list
            Expanded(
              child: _DemoMessageList(
                inputBoxFocus: bottomTextFeildFocusNode,
              ),
            ),

            // Bottom input field
            BottomInputField(
              focusNode: bottomTextFeildFocusNode,
            ),
          ],
        ),
      ),
    );
  }
}

// ChatComposer(
//               controller: inputController,
//               onReceiveText: (textMessage) {
//                 print(textMessage);
//               },
//               onRecordEnd: (filepath) {},
//               borderRadius: BorderRadius.circular(60),
//               sendIcon: Icons.send,
//               sendButtonBackgroundColor: AppColors.secondary,
//               textPadding: EdgeInsets.only(
//                 right: 12,
//                 top: 8,
//                 bottom: 5,
//               ),
//               padding: EdgeInsets.only(
//                 left: 12,
//                 bottom: 6,
//                 top: 1,
//                 right: 12,
//               ),
//               actions: [
//                 // camera button
//                 IconButton(
//                   splashRadius: 10,
//                   onPressed: () {},
//                   icon: Icon(Icons.camera_alt),
//                 ),
//               ],
//               keyboardType: TextInputType.multiline,
//               textFieldDecoration: InputDecoration(
//                 hintText: "Type message...",
//                 hintStyle: TextStyle(
//                   color: brightness == Brightness.light
//                       ? AppColors.textDark
//                       : AppColors.textLight,
//                 ),
//                 contentPadding: EdgeInsets.zero,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60),
//                   borderSide: BorderSide(
//                     color: Colors.transparent,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(60),
//                   borderSide: BorderSide(
//                     color: Colors.transparent,
//                   ),
//                 ),
//               ),
//               recordIcon: Icons.mic,
//               recordIconColor: AppColors.iconLight,
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               lockColor: AppColors.iconLight,
//               lockBackgroundColor: AppColors.secondary,
//               deleteButtonColor: Colors.red,
//               leading: IconButton(
//                 splashRadius: 10,
//                 onPressed: () {},
//                 icon: Icon(Icons.attach_file),
//               ),
//               composerColor: brightness == Brightness.light
//                   ? Colors.grey.shade100
//                   : AppColors.cardDark,
//             ),

// Gets keyBoard focus when user swipes
void getKeyBoardFocus(FocusNode InputBoxFocus) {
  // if (InputBoxFocus.hasFocus) {
  //   InputBoxFocus.unfocus();
  //   InputBoxFocus.requestFocus();
  // } else {
  //   InputBoxFocus.requestFocus();
  // }
  showCustomBottomSheet(
    bottomSheetContext,
    const MessageInfo(),
    .18,
    .18,
  );
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({
    Key? key,
    required this.inputBoxFocus,
  }) : super(key: key);
  final FocusNode inputBoxFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          const DateLable(lable: 'Yesterday'),
          MessageTile(
            message: 'Hello there, i left the package in front of the door',
            messageDate: '12:02 PM',
            isSender: true,
            status: MessageStatus.None,
            type: MessageType.Text,
            onSwipe: () {
              // if input box already has focus
              getKeyBoardFocus(inputBoxFocus);
            },
          ),
          MessageTile(
            message: 'Would be awesome!',
            messageDate: '12:03 PM',
            isSender: true,
            status: MessageStatus.None,
            type: MessageType.Image,
            onSwipe: () {
              // if input box already has focus
              getKeyBoardFocus(inputBoxFocus);
            },
          ),
          MessageTile(
            message: 'Hey there! First, thanks for informing me',
            messageDate: '12:03 PM',
            isSender: false,
            status: MessageStatus.Delivered,
            type: MessageType.Text,
            onSwipe: () {
              // if input box already has focus
              getKeyBoardFocus(inputBoxFocus);
            },
          ),
          // MessageTile(
          //   message: 'YAY!!!',
          //   messageDate: '12:03 PM',
          //   isSender: true,
          //   status: MessageStatus.Delivered,
          //   type: MessageType.Text,
          //   onSwipe: () {
          //     // if input box already has focus
          //     getKeyBoardFocus(inputBoxFocus);
          //   },
          // ),
        ],
      ),
    );
  }
}
