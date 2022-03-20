


import 'package:flutter/material.dart';
import 'package:smart_city/shared/componants/componants.dart';

class ChangePassword extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var currentController = TextEditingController();
    var newController = TextEditingController();
    var confirmController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        title: Text(
            'Change Password'

        ),

       elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children:[
            SizedBox(
              height: 80,
            ),
            defaultFormField(
              context: context,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'enter your Password if exist';
                }
              },
              controller: currentController,
              type: TextInputType.name,
              prefix: Icons.lock_outline,
              label: 'Current Password',
            ),
            SizedBox(
              height: 50,
            ),
            defaultFormField(
              context: context,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'enter your Password if exist';
                }
              },
              controller: currentController,
              type: TextInputType.name,
              prefix: Icons.lock_outline,
              label: 'New Password',
            ), SizedBox(
              height: 50,
            ),
            defaultFormField(
              context: context,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'enter your Password if exist';
                }
              },
              controller: currentController,
              type: TextInputType.name,
              prefix: Icons.lock_outline,
              label: 'Confirm Password',
            ),
            SizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child:  defaultButton(
                  function: () {

                  },
                  text: 'Change Password',
                  isUpperCase: false
                ),
              ),
            ),
            TextButton(

              style: ButtonStyle(




                elevation: MaterialStateProperty.all(0),
              ),
                onPressed: (){},
                child: Text('Forget password?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  
                ),
                  
                ),
              
            ),
          ],
        ),
      ),
    );
  }
}