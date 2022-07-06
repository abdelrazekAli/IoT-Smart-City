import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('About Us') ,

      ),
      body: Text('Contact With Us',style: TextStyle(fontSize: 30),),
    );
  }
}
