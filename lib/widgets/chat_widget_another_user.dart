import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../themes/colors.dart';

class ChatFriendUserWidget extends StatelessWidget {
  const ChatFriendUserWidget({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 22),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: anotherUserMessage,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: Colors.white,

          ),),
      ),
    );
  }
}