import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/modules/password/password_reset.dart';
import 'package:smart_city/modules/register/cubit/cubit.dart';
import 'package:smart_city/modules/register/cubit/states.dart';
import 'package:smart_city/modules/verify/cubit/states.dart';
import 'package:smart_city/modules/verify/cubit/verify_cubit.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';

class VerifyPassword extends StatefulWidget {
  @override
  _VerifyPassword createState() => _VerifyPassword();
}

class _VerifyPassword extends State<VerifyPassword> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var otpController = TextEditingController();

  String currentText = "";
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ParkingVerifyCubit(),
      child: BlocConsumer<ParkingVerifyCubit, ParkingVerifyStates>(
        listener: (context, state) {
          if (state is ParkingVerifyPassSuccessState) {
            if (state.loginModel.status) {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
              navigateTo(
                context,
                PasswordReset(),
              );
            } else {
              showToast(
                text: state.loginModel.message,
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    //color: const Color(0xffffffff),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: <Widget>[
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
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Email Address Verification',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8),
                            child: RichText(
                              text: TextSpan(
                                  text: "Enter the code sent to ",
                                  children: [
                                    TextSpan(
                                        text: emailController.text,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ],
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 15)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 30),
                              child: PinCodeTextField(
                                controller: otpController,
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                //  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                obscureText: true,
                                obscuringCharacter: '*',
                                obscuringWidget: const Text(
                                  "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Your OTP';
                                  } else
                                    return null;
                                },
                                pinTheme: PinTheme(
                                  inactiveColor: Colors.grey[200],
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: Colors.white,
                                  activeColor: Colors.blueGrey,
                                  disabledColor: Colors.grey,
                                  selectedColor: Colors.blueGrey,
                                  errorBorderColor: Colors.redAccent,
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                               //   activeFillColor: Colors.white,
                                ),
                                cursorColor: Colors.black,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                boxShadows: const [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black,
                                    blurRadius: 0,
                                  )
                                ],
                                onCompleted: (v) {
                                  if (kDebugMode) {
                                    print("Completed");
                                  }
                                },
                                onChanged: (value) {
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                  setState(() {
                                    currentText = value;
                                  });
                                },
                                beforeTextPaste: (text) {
                                  return true;
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ConditionalBuilder(
                              condition:
                                  state is! ParkingVerifyPassLoadingState,
                              builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ParkingVerifyCubit.get(context)
                                        .verifyPass(
                                      email: emailController.text,
                                      otp: otpController.text,
                                    );
                                  }
                                },
                                text: 'Send',
                                isUpperCase: true,
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ],
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
