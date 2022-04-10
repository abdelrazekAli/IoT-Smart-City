import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/verify/cubit/states.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';

class ParkingVerifyCubit extends Cubit<ParkingVerifyStates>
{
  ParkingVerifyCubit(): super(ParkingVerifyInitialState());

  static  ParkingVerifyCubit get(context) => BlocProvider.of(context);

  ParkingLoginModel loginModel;


  void verifyEmail({
    @required String email,
    @required String otp,


  }) {
    emit(ParkingVerifyEmailLoadingState());
    DioHelper.postData(
      url: VerifyEmail,
      data: {
        'email': email,
        'otp': otp,
      },
    ).then((value) {
      print(value.data);
      loginModel = ParkingLoginModel.fromJson(value.data);





      emit(ParkingVerifyEmailSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingVerifyEmailErrorState(error.toString()));
    });
  }
  void verifyPass({
    @required String email,
    @required String otp,


  }) {
    emit(ParkingVerifyPassLoadingState());
    DioHelper.postData(
      url: Verify_Pass,
      data: {
        'email': email,
        'otp': otp,
      },
    ).then((value) {
      print(value.data);

      loginModel = ParkingLoginModel.fromJson(value.data);



      emit(ParkingVerifyPassSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingVerifyPassErrorState(error.toString()));
    });
  }


}
