import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/style/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

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
          carIntController.text=model.data.carInt ;

          return ConditionalBuilder(

            condition: ParkingCubit.get(context).userModel != null,
            builder: (context) {

              return Scaffold(
                appBar: AppBar(
                  title: Text('Edit Profile'),
                  elevation: 10,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only( right: 10),
                      child: TextButton(
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        onPressed: (){
                          if (formKey.currentState.validate()) {
                            ParkingCubit.get(context).updateUserData(
                              username: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                              carStr: carStrController.text,
                              carInt: carIntController.text,

                            );

                          }

                        },

                      ),
                    )



                  ],
                ),
                body: SingleChildScrollView(

                  child: Column(
                    children: [


                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                if (state is ParkingLoadingUpdateState)

                                  LinearProgressIndicator(color: Colors.blueAccent,),
                                SizedBox(height: 20,),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    SizedBox(height: 20,),
                                    CircleAvatar(
                                      radius: 65,
                                      backgroundColor:
                                      Colors.deepPurpleAccent,
                                      child: CircleAvatar(
                                        radius: 64,
                                        backgroundImage: AssetImage('assets/images/onboard_1.png'),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {

                                      },
                                      icon: CircleAvatar(
                                        radius: 18,
                                        child: Icon(
                                          IconBroken.Camera,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 60,
                                ),
                                defaultFormField(
                                controller: nameController,
                                  type: TextInputType.name,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'name must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Name',
                                  prefix: Icons.person,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (email) {
                                    if(email.isEmpty){
                                      return 'Please Enter Your Email Address';
                                    }else if(!EmailValidator.validate(email))
                                    {
                                      return 'Enter a valid email';
                                    }else
                                      return null;
                                  }
                                  ,
                                  label: 'Email Address',
                                  prefix: Icons.email,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter Your Phone Number';
                                    }if(value.length <9){
                                      return 'Please Enter a Valid Phone Number';
                                    }
                                  },
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
                                          format: [LengthLimitingTextInputFormatter(3)],
                                          context: context,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'enter your car id if exist';
                                            }
                                          },
                                          controller:carStrController,
                                          type: TextInputType.name,
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
                                          format: [LengthLimitingTextInputFormatter(4)],
                                          context: context,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'enter your car num if exist';
                                            }
                                          },
                                          controller: carIntController,
                                          type: TextInputType.number,
                                          prefix: Icons.directions_car_rounded,


                                          label: 'CAR Num',
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
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

