import 'dart:ui';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/modules/login/cubit/login_cubit.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/password/forget_password.dart';
import 'package:smart_city/modules/register/register_screen.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';




class ParkingLoginScreen extends StatefulWidget {




  @override
  _ParkingLoginScreenState createState() => _ParkingLoginScreenState();
}

class _ParkingLoginScreenState extends State<ParkingLoginScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool _hasInternet =false;
    final color = _hasInternet ? Colors.green :Colors.red;
    final text = _hasInternet ? 'Internet': 'No Internet';
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var carIntController = TextEditingController();
    var carStrController = TextEditingController();
    var phoneController = TextEditingController();;



    @override
    void dispose(){
      emailController.dispose();

    }

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
              print(state.loginModel.data.username);
              print(state.loginModel.data.uid);
              print(state.loginModel.data.carInt);
              print(state.loginModel.data.carStr);
              print(state.loginModel.data.phone);
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

                           SizedBox(
                             height: 30,
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

                               function: ()async
                               {
                                 _hasInternet=await InternetConnectionChecker().hasConnection ;

                                if(_hasInternet){

                                  if(formKey.currentState.validate())
                                  {
                                    ParkingLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                  }
                                }else
                                  showToast(
                                      text: 'Please Check Your Network Connection',
                                      state: ToastStates.SUCCESS
                                  );


                               },
                               text: 'Log In',

                               isUpperCase: true,
                             ),
                             fallback: (context)=> Center(child: CircularProgressIndicator()),
                           ),
                           SizedBox(
                             height: 5,
                           ),
                           Column(
                             children: [
                               Center(
                                 child: TextButton(
                                   style: ButtonStyle(
                                     // overlayColor: MaterialStateProperty.all(HexColor('12345678')),
                                     elevation: MaterialStateProperty.all(0),

                                   ),
                                   onPressed: () {
                                     navigateTo(context, ForgetPassword());
                                   },
                                   child: Text(
                                     'Forget password?',
                                     style: TextStyle(
                                       color: Colors.black,
                                   //    fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 ),
                               ),

                               SizedBox(height: 20,),
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
