import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'loginScreen';
  static const String path = '/loginScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('login account'),
        )
    );
  }
}
