import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/shared/componants/constants.dart';
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

      emit(ParkingLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ParkingLoginErrorState(error.toString()));
    });


  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix =isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordState());
  }
}
