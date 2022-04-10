import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/register/cubit/states.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';

class ParkingRegisterCubit extends Cubit<ParkingRegisterStates>
{
  ParkingRegisterCubit(): super(ParkingRegisterInitialState());

  static  ParkingRegisterCubit get(context) => BlocProvider.of(context);

  ParkingLoginModel loginModel;


  void userRegister({
  @required String email,
    @required String password,
    @required String phone,
    @required String username,
    @required String  carStr,
    @required String carInt

  })
  {
    emit(ParkingRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:{
          'username':username,
          'email':email,
          'password':password,
          'phone':phone,
          'carStr':carStr,
          'carInt':carInt,

        },
    ).then((value) {
      print(value.data);
      loginModel= ParkingLoginModel.fromJson(value.data);
      emit(ParkingRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ParkingRegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword= !isPassword;
    suffix =isPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordVState());
  }
  IconData suffx = Icons.visibility_outlined;
  bool inPassword =true;

  void changePasswordVisibility2()
  {
    inPassword= !inPassword;
    suffx =inPassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ParkingChangePasswordV2State());
  }
  void sendOTP({
    @required String email,

  }) {
    emit(ParkingSendOTPLoadingState());
    DioHelper.postData(
      url: SendOTP,
      data: {
        'email': email,
      },
    ).then((value) {
      print(value.data);
      loginModel = ParkingLoginModel.fromJson(value.data);





      emit(ParkingSendOTPSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingSendOTPErrorState(error.toString()));
    });}




}
