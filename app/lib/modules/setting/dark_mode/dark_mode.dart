import 'package:flutter/material.dart';

class DarkMode extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Mode'),
      ),
      body: Center(
        child: Container(
          child: Text('Dark Mode'),
        ),
      ),
    );
  }
}
