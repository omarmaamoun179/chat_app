import 'package:flutter/material.dart';
import 'package:scholar_chat/model/message_model.dart';

import '../constant.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({ 
   
    Key? key,
     required this.message
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 15, bottom: 15, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: KprimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({ 
   
    Key? key,
     required this.message
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 15, bottom: 15, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
