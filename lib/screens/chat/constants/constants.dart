import 'package:flutter_emoji/flutter_emoji.dart';

var parser = EmojiParser();

// message sent status (wheather it is seen, delivered and seen)
abstract class MessageStatus {
  static const String Sent = 'sent';
  static const String Delivered = 'delivered';
  static const String Seen = 'seen';
  static const String None = '';
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
