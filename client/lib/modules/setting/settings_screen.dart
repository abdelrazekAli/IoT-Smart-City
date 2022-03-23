import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:smart_city/modules/profile/edit_profile_screen.dart';
import 'package:smart_city/modules/setting/dark_mode/dark_mode.dart';
import 'package:smart_city/shared/componants/componants.dart';
import 'package:smart_city/shared/componants/constants.dart';
import 'package:smart_city/shared/cubit/cubit.dart';

import '../changePassword.dart';



class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Settings'
        ),
        elevation: 10,
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          buildListTile(
             // Colors.black,
              "Edit Profile",
              Icons.edit_outlined,
                  (){navigateTo(context,EditProfileScreen());
              }
              ),
          myDivider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Icon(Icons.dark_mode,),
                  SizedBox(width: 30,),
                  Text('Dark Mode',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),),
                  Spacer(),
                  RollingSwitch.icon(
                    width: 110,
                    height: 50,

                    onChanged: (bool state) {

                      AppCubit.get(context).changeAppMode();
                    },
                    rollingInfoRight: const RollingIconInfo(
                      icon: Icons.dark_mode_rounded,
                      backgroundColor: Colors.black,
                      text: Text(
                        'DARK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    rollingInfoLeft: const RollingIconInfo(
                      icon: Icons.light_mode_outlined,
                      iconColor: Colors.black,
                      backgroundColor: Colors.blueAccent,
                      text: Text('LIGHT'),
                    ),
                  ),

                ],
              ),
            ),
          ),
          myDivider(),
          buildListTile(
             // Colors.black,
              "Change Password",
              Icons.lock_outlined,
                  (){
                    navigateTo(context, (ChangePassword()));
              }
          ),
          myDivider(),
          buildListTile(
             // Colors.black,
              "Log Out",
              Icons.logout_rounded,
                  (){
                    signOut(context);
              }
          ),

        ],
      ),
    );
  }
}


