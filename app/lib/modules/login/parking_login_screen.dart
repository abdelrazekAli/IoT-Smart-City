import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/register/register_screen.dart';
import 'package:smart_city/shared/componants/componants.dart';
import 'package:smart_city/shared/componants/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;




class ParkingLoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=> ParkingLoginCubit(),
      child: BlocConsumer<ParkingLoginCubit, ParkingLoginStates>(
        listener: (context , state){

          if(state is ParkingLoginSuccessState)
          {

            if(state.loginModel.status)
            {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, LayoutScreen(),);
              });
              CacheHelper.saveData(
                key: 'uid',
                value: state.loginModel.data.uid,
              ).then((value) {
                uid = state.loginModel.data.uid;
              });


            }
          }
          else if(state is ParkingLoginErrorState)
          {

            showToast(
              text: ParkingLoginCubit.get(context).loginModel.message,
              state: ToastStates.ERROR,

            );
          }


        },
        builder: (context, state)
        {
          timeDilation=3.0;
          Size size = MediaQuery.of(context).size;
          return Scaffold(

            body: Stack(
             children: [
               Container(
                   decoration: BoxDecoration(
                       image: DecorationImage(image: AssetImage('assets/images/pp1.png',),
                         fit: BoxFit.cover,
                       )
                   ),
                   child: BackdropFilter(filter:
                   ImageFilter.blur(
                     sigmaX:10,
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
                             child: Text('Sign In',
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
                         /*  Hero(
                             tag: 'TextTag',
                             child: Text('Enter Your Data To Continue',
                                 style:TextStyle(
                                   color: Colors.white,
                                   fontSize: 12,
                                   fontWeight: FontWeight.w700,
                                   fontStyle: FontStyle.italic,
                                 )),
                           ),*/
                           SizedBox(
                             height: 30,
                           ),
                           defaultFormField(
                             controller: emailController,
                             type: TextInputType.emailAddress,
                             validate: (String value) {
                               if (value.isEmpty) {
                                 return 'Please Enter Your Email Address';
                               }
                             },
                             label: 'Email Address',
                             prefix: Icons.email_outlined,
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           defaultFormField(

                             controller: passwordController,
                             type: TextInputType.visiblePassword,
                             suffix:   ParkingLoginCubit.get(context).suffix,


                             onSubmit: (value)
                             {
                               if(formKey.currentState.validate())
                               {
                                 print(ParkingLoginCubit.get(context).loginModel.message);
                                 ParkingLoginCubit.get(context).userLogin(
                                   email: emailController.text,
                                   password: passwordController.text,
                                 );
                               }
                             },
                             isPassword:  ParkingLoginCubit.get(context).isPassword,
                             suffixPressed: ()
                             {
                               ParkingLoginCubit.get(context).changePasswordVisibility();
                             },
                             validate: (String value) {
                               if (value.isEmpty) {
                                 return 'Password is too Short';
                               }
                             },
                             label: 'Password',
                             prefix: Icons.lock_outline,
                           ),
                           SizedBox(
                             height: 30,
                           ),
                           ConditionalBuilder(
                             condition:state is! ParkingLoginLoadingState ,
                             builder: (context)=> defaultButton(

                               function: ()
                               {



                                 if(formKey.currentState.validate())
                                 {
                                   ParkingLoginCubit.get(context).userLogin(
                                     email: emailController.text,
                                     password: passwordController.text,

                                   );


                                 }


                               },
                               text: 'Log In',

                               isUpperCase: true,
                             ),
                             fallback: (context)=> Center(child: CircularProgressIndicator()),
                           ),
                           SizedBox(
                             height: 15,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 'Don\'t have an Account?',
                               ),
                               defaultTextButton(
                                 function: () {
                                   navigateTo(
                                     context,
                                     ParkingRegisterScreen(),
                                   );
                                 },
                                 text: 'Sign Up',

                               ),
                             ],
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
