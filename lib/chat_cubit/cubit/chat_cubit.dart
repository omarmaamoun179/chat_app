import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constant.dart';

import '../../model/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessagesCollections);
  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          Kmessage: message,
          KCreatedAt: DateTime.now(),
          'id': email,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void getMessage() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];
      for (var doc in event.docs) {
        print('docs = ' '${doc}');
        messageList.add(Message.fromjson(doc));
        print('success');
      }
      emit(ChatSuccess(message: messageList));
    });
  }
}
