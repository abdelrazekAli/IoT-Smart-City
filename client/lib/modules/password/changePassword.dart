import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/password/forget_password.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bool _hasInternet =false;
    final color = _hasInternet ? Colors.green :Colors.red;
    final text = _hasInternet ? 'Internet': 'No Internet';
    var oldPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ParkingLoginCubit(),
      child: BlocConsumer<ParkingLoginCubit, ParkingLoginStates>(
        listener: (context, state) {
          if (state is ParkingChangePasswordSuccessState)
          {
            if (state.passwordModel.status) {
              showToast(
                text: ParkingLoginCubit.get(context).passwordModel.message,
                state: ToastStates.SUCCESS,
              );
              print(state.passwordModel.message);
            }
            else  {

              showToast(
                text: ParkingLoginCubit.get(context).passwordModel.message,
                state: ToastStates.ERROR,
              );

            }
          }

        },
        builder: (context, state) {
          timeDilation = 3.0;
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: ListView(
              children:[
                Stack(
                children: [

                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height / 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset("assets/images/verify.png"),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              defaultFormField(
                                controller: oldPasswordController,
                                type: TextInputType.visiblePassword,
                                suffix: ParkingLoginCubit.get(context).suffix,
                                onSubmit: (value) {

                                },
                                isPassword:
                                ParkingLoginCubit.get(context).isPassword,
                                suffixPressed: () {
                                  ParkingLoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Your Current Password';
                                  }
                                },
                                label: 'Current Password',
                                prefix: Icons.lock_outline,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              defaultFormField(
                                controller: newPasswordController,
                                type: TextInputType.visiblePassword,
                                suffix: ParkingLoginCubit.get(context).suffiix,
                                onSubmit: (value) {

                                },
                                isPassword:
                                ParkingLoginCubit.get(context).cPassword,
                                suffixPressed: () {
                                  ParkingLoginCubit.get(context)
                                      .changePasswordVisibility2();
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Create Password';
                                  }
                                },
                                label: 'New Password',
                                prefix: Icons.lock_outline,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                controller: confirmPasswordController,
                                type: TextInputType.visiblePassword,
                                suffix: ParkingLoginCubit.get(context).sufx,
                                onSubmit: (value) {
                                  if (formKey.currentState.validate()) {}
                                },
                                isPassword:
                                ParkingLoginCubit.get(context).nPassword,
                                suffixPressed: () {
                                  ParkingLoginCubit.get(context)
                                      .changePasswordVisibility3();
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter re Password';
                                  }
                                  if (newPasswordController.text !=
                                      confirmPasswordController.text) {
                                    return 'Password don\'t match';
                                  }
                                },
                                label: 'Confirm Password',
                                prefix: Icons.lock_outline,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FlutterPwValidator(
                                controller: newPasswordController,
                                minLength: 8,
                                uppercaseCharCount: 1,
                                numericCharCount: 2,
                                specialCharCount: 1,
                                width: 400,
                                height: 150,
                                onSuccess: () {
                                  return 'Success';
                                },
                                onFail: () {
                                  return 'Password is Weak';
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition:
                                state is! ParkingChangePasswordLoadingState,
                                builder: (context) => defaultButton(
                                  function: () async{
                                    _hasInternet=await InternetConnectionChecker().hasConnection ;
                                   if(_hasInternet){

                                     if (formKey.currentState.validate()) {
                                       ParkingLoginCubit.get(context)
                                           .changePassword(
                                         oldPassword: oldPasswordController.text,
                                         newPassword: newPasswordController.text,
                                       );
                                     }
                                   }else{
                                     showToast(
                                         text: 'Please Check Your Network Connection',
                                         state: ToastStates.SUCCESS);
                                   }
                                  },
                                  text: 'Change Password',
                                  isUpperCase: false,
                                ),
                                fallback: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                  ),
                                  onPressed: () {
                                    navigateTo(context, ForgetPassword());
                                  },
                                  child: Text(
                                    'Forget password?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],),
          );
        },
      ),
    );
  }
}