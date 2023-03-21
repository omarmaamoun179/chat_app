import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/model/message_model.dart';

import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final ScrollController _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  static String id = 'chat page';
  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KprimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              KLogo,
              height: 60,
            ),
            Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messageList = state.message; 
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) =>
                      messageList[index].id == email
                          ? ChatBubble(
                              message: messageList[index],
                            )
                          : ChatBubbleForFriend(message: messageList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: ((data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                );
              }),
              decoration: InputDecoration(
                hintText: 'Enter your message ',
                suffixIcon: Icon(Icons.send_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(color: KprimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
