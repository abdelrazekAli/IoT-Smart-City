import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/verify/cubit/states.dart';
import 'package:smart_city/modules/verify/cubit/verify_cubit.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';

class PasswordReset extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var newPasswordController = TextEditingController();
    var confirmPasswordController = TextEditingController();



    return BlocProvider(
      create: (BuildContext context) => ParkingLoginCubit(),
      child: BlocConsumer<ParkingLoginCubit, ParkingLoginStates>(
        listener: (context, state) {
          if (state is ParkingNewPasswordSuccessState) {
            if (state.passwordModel.status) {
              showToast(
                text: state.passwordModel.message,
                state: ToastStates.SUCCESS,
              );
              navigateAndFinish(context,
                  ParkingLoginScreen()
              );

            }else  {

              showToast(
                text: state.passwordModel.message,
                state: ToastStates.ERROR,
              );

            }
          }
        },
        builder: (context, state) {


          emailController.text = email;
          timeDilation = 3.0;

          return Scaffold(
            body: Stack(
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
                            SizedBox(
                              height: 20,
                            ),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.all( 8.0),
                              child: Text(
                                'Reset Password',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,
                                fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(
                              height: 30,
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
                              state is! ParkingNewPasswordLoadingState,
                              builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ParkingLoginCubit.get(context)
                                        .newPass(
                                        password: newPasswordController.text,
                                        email: emailController.text,

                                    );
                                  }
                                },
                                text: 'New Password',
                                isUpperCase: false,
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}