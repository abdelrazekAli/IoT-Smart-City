import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/modules/profile/edit_profile_screen.dart';
import 'package:smart_city/modules/setting/dark_mode/dark_mode.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/cubit/cubit.dart';

import '../password/changePassword.dart';



class SettingsScreen extends StatefulWidget {


  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool _hasInternet =false;
    final color = _hasInternet ? Colors.green :Colors.red;
    final text = _hasInternet ? 'Internet': 'No Internet';
    return BlocConsumer<ParkingCubit,ParkingStates>(
        listener: (context,state){},
          builder: (context,state){
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
                      ()async{
                        _hasInternet=await InternetConnectionChecker().hasConnection ;

                          if (_hasInternet) {
                            navigateTo(
                              context,
                              EditProfileScreen(),
                            );

                        }
                        else{
                          showToast(
                              text: 'Please Check Your Network Connection', state: ToastStates.ERROR
                          );
                        }
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
    );
  }
}


