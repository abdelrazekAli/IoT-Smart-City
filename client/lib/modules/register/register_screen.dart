import 'dart:ui';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/register/cubit/cubit.dart';
import 'package:smart_city/modules/register/cubit/states.dart';
import 'package:smart_city/modules/verify/verify_email.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';

class ParkingRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var carStrController = TextEditingController();
  var carIntController = TextEditingController();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ParkingRegisterCubit(),
      child: BlocConsumer<ParkingRegisterCubit, ParkingRegisterStates>(
        listener: (context, state) {

          if (state is ParkingRegisterSuccessState) {
            ParkingRegisterCubit.get(context).sendOTP(email: emailController.text);
            if (state.loginModel.status) {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
              CacheHelper.saveData(
                  key: 'email',
                  value: state.loginModel.data.email


              ).then((value)
              {
                email= emailController.text;
              } );
              CacheHelper.saveData(
                  key: 'uid',
                  value: state.loginModel.data.uid


              ).then((value) {

                uid = state.loginModel.data.uid;
                navigateAndFinish(
                  context,
                  VerifyEmail(),
                );
              });
            }
            else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }

        },
        builder: (context, state) {
          timeDilation=3.0;
          Size size= MediaQuery.of(context).size;
          return Scaffold(

            body: Stack(
              children:[

                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/images/pp1.png',),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: BackdropFilter(filter:
                    ImageFilter.blur(
                      sigmaX:5,
                      sigmaY:10.5,
                    ),
                      child: Container(
                        color: Color(0xFF31AAE2).withOpacity(.3),
                      ),)
                ),

              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: 'TextTag',
                            child: Text('Sign Up',
                                style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30
                                ),

                            ),
                          ),
                          SizedBox(height: 20,),

                          Text(
                            '',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            autofill: [AutofillHints.email],
                            validate: (email) {
                              if(email.isEmpty){
                                return 'Please Enter Your Email Address';
                              }else if(!EmailValidator.validate(email))
                              {
                                return 'Enter a valid email';
                              }else
                                return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                          ),

                          SizedBox(
                            height: 15,
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
                            height: 30,
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


                                    label: 'CAR NUM ',
                                  ),

                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ParkingRegisterCubit.get(context).suffix,

                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                ParkingRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isPassword:
                            ParkingRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              ParkingRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Create Password';

                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(

                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            suffix:   ParkingRegisterCubit.get(context).suffx,


                            onSubmit: (value)
                            {
                              if(formKey.currentState.validate())
                              {

                              }
                            },
                            isPassword:  ParkingRegisterCubit.get(context).inPassword,
                            suffixPressed: ()
                            {
                              ParkingRegisterCubit.get(context).changePasswordVisibility2();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter re Password';

                              }if(passwordController.text !=confirmPasswordController.text ){
                                return 'Password don\'t match';
                              }
                            },
                            label: 'Confirm Password',
                            prefix: Icons.lock_outline,
                            onTap: (){
                            }
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FlutterPwValidator(
                            controller: passwordController,
                            minLength: 8,
                            uppercaseCharCount: 1,
                            numericCharCount: 3,
                            specialCharCount: 1,
                            width: 400,
                            height: 150,
                            onSuccess: (){
                              return 'Success';
                            },
                            onFail: (){
                              return 'Password is Weak';
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ParkingRegisterLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  ParkingRegisterCubit.get(context).userRegister(
                                    username: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    carStr: carStrController.text,
                                    carInt: carIntController.text,
                                  );
                                 /* ParkingRegisterCubit.get(context).sendOTP(
                                      email: emailController.text
                                  );*/
                                }
                              },
                              text: 'sign up',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              ],
            ),
          );
        },
      ),
    );
  }
}
