import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/profile/edit_profile_screen.dart';
import 'package:smart_city/modules/profile/profile.dart';
import 'package:smart_city/modules/setting/settings_screen.dart';
import 'package:smart_city/shared/componants/componants.dart';
import 'package:smart_city/shared/componants/constants.dart';
import 'package:smart_city/shared/cubit/cubit.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:smart_city/shared/style/theme.dart';

class LayoutScreen extends StatelessWidget {
  Color color = ThemeMode.light != null ? HexColor('333739') : Colors.white;

  var emailController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
        listener: (context, state) {
      var model = ParkingCubit.get(context).userModel;

      emailController.text = model.data.email;
      nameController.text = model.data.username;
    }, builder: (context, state) {
      var cubit = ParkingCubit.get(context);
      return Scaffold(
        appBar: AppBar(


          title: Text('Smart City'),
          elevation: 10,
        ),
        body: cubit.bottomScreen[cubit.currentIndex],
        drawer: Container(
          color: Colors.white,
          child: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey
                  ),
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(

                          radius: 31,
                          backgroundColor: Colors.deepPurpleAccent,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/onboard_1.jpg')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(

                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(nameController.text,
                                  style: TextStyle(
                                    fontSize: 20, color: Colors.black, fontFamily: '',)),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(emailController.text,
                                style: TextStyle(
                                  fontSize: 14, color: Colors.black, fontFamily: '',),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      navigateTo(
                        context,
                        ProfileScreen(),
                      );
                    },
                  )
                ),

            //   myDivider(),
                SizedBox(
                  height: 30,
                ),
                buildListTile(
                     "Main Screen", Icons.home_outlined, () {}),
                SizedBox(
                  height: 15,
                ),
                buildListTile(
                     "Profile", Icons.account_box_outlined, () {
                  navigateTo(
                    context,
                    ProfileScreen(),
                  );
                }),
                SizedBox(
                  height: 15,
                ),
                buildListTile(
                     "Settings", Icons.settings_outlined, () {
                  navigateTo(context, SettingsScreen());
                }),
                SizedBox(
                  height: 15,
                ),
                myDivider(),
                SizedBox(
                  height: 15,
                ),
                buildListTile( "Log out", Icons.logout_outlined,
                    () {
                  signOut(context);
                }),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            cubit.changeBottom(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_outlined),
              label: 'Parking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),

          ],
        ),
      );
    });
  }
}

/*showMyAlertDialog(BuildContext context) {
  var emailController = TextEditingController();
  var model = ParkingCubit.get(context).userModel;

  emailController.text = model.data.email;
  SimpleDialog dialog = SimpleDialog(
    backgroundColor: Colors.grey[100],
    title: Row(
      children: [
        Text(
          "Accounts",
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            addAcount(context);
          },
          icon: Icon(Icons.add),
        )
      ],
    ),
    children: <Widget>[
      SimpleDialogOption(
          onPressed: () {},
          child: Text(emailController.text,
              style: TextStyle(fontWeight: FontWeight.bold))),
    ],
  );

  Future futureValue = showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}*/
/*ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.black, ),
                              child: Row(
                                children: [
                                  Text(emailController.text,style: TextStyle(fontWeight: FontWeight.bold),),
                                  Spacer(),
                                  IconButton(
                                      onPressed: (){showMyAlertDialog(context);}, icon: Icon(Icons.keyboard_arrow_down))
                                ],
                              ),
                              onPressed: () {
                                showMyAlertDialog(context);
                              },
                            ),*/

