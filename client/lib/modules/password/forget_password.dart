import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/verify/verify_password.dart';
import 'package:smart_city/modules/register/cubit/cubit.dart';
import 'package:smart_city/modules/register/cubit/states.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {



  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bool _hasInternet =false;
    final color = _hasInternet ? Colors.green :Colors.red;
    final text = _hasInternet ? 'Internet': 'No Internet';
    var emailController = TextEditingController();


    return BlocProvider(
      create: (BuildContext context) => ParkingRegisterCubit(),
      child: BlocConsumer<ParkingRegisterCubit, ParkingRegisterStates>(
        listener: (context, state) {
          {
            if (state is ParkingSendOTPSuccessState)
            {
              if(state.loginModel.status )
              {

                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCCESS,
                );
                CacheHelper.saveData(
                    key: 'email',
                    value: emailController.text


                ).then((value) {

                  email = emailController.text;
                  navigateTo(context,
                      VerifyPassword()
                  );
                });

              }else
              {
                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCCESS,
                );
              }
            }

          }
        },
        builder: (context, state) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: SizedBox(

                          height: MediaQuery.of(context).size.height / 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset("assets/images/verify.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Email Address Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                autofill: [AutofillHints.email],
                                validate: (email) {
                                  if (email.isEmpty) {
                                    return 'Please Enter Your Email Address';
                                  } else if (!EmailValidator.validate(email)) {
                                    return 'Enter a valid email';
                                  } else
                                    return null;
                                },
                                label: 'Email Address',
                                prefix: Icons.email_outlined,

                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ConditionalBuilder(
                                condition: state is! ParkingSendOTPLoadingState,
                                builder: (context) => defaultButton(
                                  function: ()async
                                  {
                                    _hasInternet=await InternetConnectionChecker().hasConnection ;
                                   if(_hasInternet){
                                     if(formKey.currentState.validate())
                                     {
                                       ParkingRegisterCubit.get(context).sendOTP(email: emailController.text);

                                     }

                                   }
                                    else
                                      showToast(
                                          text: 'Please Check Your Network Connection',
                                          state: ToastStates.SUCCESS
                                      );
                                  },
                                  text: 'Send',
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }



}

