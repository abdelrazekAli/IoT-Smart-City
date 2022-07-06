import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:restart_app/restart_app.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var carStrController=TextEditingController();
  var carIntController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ParkingCubit.get(context).userModel;

          nameController.text = model.data.username;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;
          carStrController.text=model.data.carStr;
          carIntController.text=model.data.carInt;

          return ConditionalBuilder(

            condition: ParkingCubit.get(context).userModel != null,
            builder: (context) {

              return Scaffold(
                appBar: AppBar(
                  title: Text(' Profile'),
                  elevation: 10,
                  actions: [
                    IconButton(
                      onPressed: ()
                      {
                        navigateTo(
                            context,
                            EditProfileScreen()
                        );
                      },
                      icon: Icon(Icons.edit_outlined,
                        color: Colors.blue,
                      ),

                    ),
                  ],
                ),
                body: Center(

                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 65,

                            backgroundColor: Colors.deepPurpleAccent,
                            child: CircleAvatar(
                                radius: 64,
                                backgroundImage: AssetImage('assets/images/onboard_1.png')
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text(nameController.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,

                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                if (state is ParkingLoadingUpdateState)
                                  LinearProgressIndicator(),
                                SizedBox(
                                  height: 40,
                                ),

                                defaultFormField(
                                  isClickable: false,
                                  controller: emailController,
                                  label: 'Email Address',
                                  prefix: Icons.email,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  isClickable: false,
                                  controller: phoneController,
                                  label: 'Phone',
                                  prefix: Icons.phone,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                        ),



                                        child: defaultFormField(
                                          isClickable: false,
                                          context: context,

                                          controller:carStrController,
                                          prefix:
                                          Icons.directions_car_rounded,


                                          label: 'CAR ID ',
                                        ),

                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),

                                        ),

                                        child: defaultFormField(
                                          isClickable: false,
                                          context: context,
                                          controller: carIntController,
                                          prefix: Icons.directions_car_rounded,


                                          label: 'CAR Num ',
                                        ),

                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}