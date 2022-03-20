import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Stack(
        children:[
          Container(
          //color: Colors.teal.shade800,
        ),
          Center(
            child: Container(
              child: Text('Booking',style: TextStyle(fontSize: 20),),
            ),
          ),
        ],
      ),
    );
  }
}
