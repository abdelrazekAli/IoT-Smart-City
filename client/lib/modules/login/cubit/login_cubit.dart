import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';



class ParkingLoginCubit extends Cubit<ParkingLoginStates>
{
  ParkingLoginCubit() :super (ParkingLoginInitialState());

  static  ParkingLoginCubit get(context) => BlocProvider.of(context );

  ParkingLoginModel loginModel;







  void userLogin({
  @required String email,
    @required String password,

  })
  {
    emit(ParkingLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data:{
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      loginModel= ParkingLoginModel.fromJson(value.data);
      uid=loginModel.data.uid.toString();
      username =loginModel.data.username.toString();
      email =loginModel.data.email.toString();
      phone =loginModel.data.phone.toString();
      carStr =loginModel.data.carStr.toString();
      carInt =loginModel.data.carInt.toString();

      emit(ParkingLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ParkingLoginErrorState(error.toString()));
    });


  }
  ParkingLoginModel passwordModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;


  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix =isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordV1State());
  }

  IconData sufx = Icons.visibility_outlined;
  bool nPassword =true;
  void changePasswordVisibility3()
  {
    nPassword= !nPassword;
    sufx =nPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordV3State());
  }


  IconData suffiix = Icons.visibility_outlined;
  bool cPassword =true;
  void changePasswordVisibility2()
  {
    cPassword= !cPassword;
    suffiix =cPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordV2State());
  }


  void changePassword({

    @required String oldPassword,
    @required String newPassword,

  })
  {
    emit(ParkingChangePasswordLoadingState());

    DioHelper.putData(
      url: 'password-change/$uid',
      token: token,
      data: {
        'oldPassword' : oldPassword,
        'newPassword' : newPassword,
      },
    ).then((value) {

      passwordModel = ParkingLoginModel.fromJson(value.data);
      print('+++++++++++++++++++++++++++++++++');

      emit(ParkingChangePasswordSuccessState(passwordModel));
    }).catchError((error) {
      print('------------------------------------------------');
      print(error.toString());
      emit(ParkingChangePasswordErrorState(error.toString()));
    });
  }
  void newPass({
    @required String password,
    @required String email,





  }) {
    emit(ParkingNewPasswordLoadingState());
    DioHelper.postData(
      url: Password_Reset,
      data: {

        'password': password,
        'email': email,

      },
    ).then((value) {
      print(value.data);

      loginModel = ParkingLoginModel.fromJson(value.data);


      emit(ParkingNewPasswordSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingNewPasswordErrorState(error.toString()));
    });
  }




}

