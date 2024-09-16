import 'package:chat_flutter/components/my_contact.dart';
import 'package:chat_flutter/components/my_loading.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/services/auth/service.dart';
import 'package:chat_flutter/components/my_drawer.dart';
import 'package:chat_flutter/services/chat/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final AuthService authService = AuthService();
final ChatService chatService = ChatService();

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() async {
      try {
        await authService.signOut();
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Contacts'),
      ),
      drawer: MyDrawer(
        signOutAction: signOut,
      ),
      body: StreamBuilder(
          stream: chatService.getUsers(),
          builder: (context, snapsot) {
            if (snapsot.hasError) {
              return const Text('error');
            }
            if (snapsot.connectionState == ConnectionState.waiting) {
              return const MyLoading();
            }
            return ListView(
              children: snapsot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList(),
            );
          }),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    final String email = userData['email'];
    final User? currentUser = authService.getCurrentUser();

    if (email != currentUser?.email) {
      return MyContact(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiveEmail: email,
                receiverId: userData['uid'],
              ),
            ),
          );
        },
        userEmail: email,
      );
    }
    return Container();
  }
}
