import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isShowLoginpage = true;

  void togglePage() {
    setState(() {
      _isShowLoginpage = !_isShowLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isShowLoginpage) {
      return LoginPage(
        regsiterPage: togglePage,
      );
    }
    return RegisterPage(
      loginPage: togglePage,
    );
  }
}
