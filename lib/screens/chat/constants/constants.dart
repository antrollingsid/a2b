import 'package:a2b/main/utils/allConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

var parser = EmojiParser();

// message sent status (wheather it is seen, delivered and seen)
abstract class MessageStatus {
  static final String Sent = 'sent';
  static final String Delivered = 'delivered';
  static final String Seen = 'seen';
  static final String None = '';
}

// message type
enum MessageType {
  Text,
  Audio,
  Video,
  Gif,
  Image,
}

// Message reaction
abstract class Reactions {
  static final String Smiley = parser.emojify(':slightly_smiling_face:');
  static final String Heart = parser.emojify(':heart:');
  static final String Wow = parser.emojify(':open_mouth:');
  static final String Sad = parser.emojify(':cry:');
  static final String Angry = parser.emojify(':rage:');
  static final String Like = parser.emojify(':thumbsup:');
}
