import 'package:chat_flutter/components/my_loading.dart';
import 'package:chat_flutter/components/my_textfield.dart';
import 'package:chat_flutter/services/auth/service.dart';
import 'package:chat_flutter/services/chat/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveEmail;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.receiveEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  FocusNode myFocusNode = FocusNode();

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      _messageController.clear();
      myFocusNode.requestFocus();
      await _chatService.sendMessage(widget.receiverId, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(widget.receiveEmail),
      ),
      body: Column(
        children: [
          Expanded(flex: 10, child: _listMessages()),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: MyTextField(
                      controller: _messageController,
                      hintText: 'Typing your messages',
                      focusNode: myFocusNode,
                      onSubmitted: (String value) {
                        sendMessage(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _listMessages() {
    final User? currentUser = _authService.getCurrentUser();
    return StreamBuilder(
      stream: _chatService.getMessages(currentUser!.uid, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MyLoading();
        }
        return ListView(
          reverse: true,
          children: snapshot.data!.docs.reversed
              .map((doc) => _messageBox(context, doc))
              .toList(),
        );
      },
    );
  }

  Widget _messageBox(BuildContext context, DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    final User? currentUser = _authService.getCurrentUser();
    final bool isMe = currentUser!.uid == data['senderId'];

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.green : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(20),
              bottomLeft:
                  isMe ? const Radius.circular(20) : const Radius.circular(0),
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          padding: const EdgeInsets.all(10),
          child: Text(
            data['message'],
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
