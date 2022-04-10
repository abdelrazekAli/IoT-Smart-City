
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/home/home_screen.dart';
import 'package:smart_city/modules/parking/parking_screen.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';

class ParkingCubit extends Cubit<ParkingStates> {
  ParkingCubit() : super(ParkingInitialStates());



  static ParkingCubit get(context) => BlocProvider.of(context);




  int currentIndex=0;

  List<Widget> bottomScreen =
  [
    ParkingScreen(),
    HomeScreen(),

  ];




  void changeBottom ( int index){
    currentIndex=index;
    emit(ParkingChangeBottomNavStates());

  }





 ParkingLoginModel userModel;

  void getUserData()
  {
    emit(ParkingLoadingUserDataState());

    DioHelper.getData(
      url:  'users/$uid',
       token: token,

    ).then((value) {
      userModel = ParkingLoginModel.fromJson(value.data);
      printFullText(userModel.data.username);

      emit(ParkingSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingErrorUserDataState());
    });
  }


  void updateUserData({

  @required String username,
    @required String email,
    @required String phone,
    @required String carStr,
    @required String carInt,

  })
  {
    emit(ParkingLoadingUpdateState());

   print( '------- $uid');
    DioHelper.putData(
      url: 'users/$uid',
      token: token,
      data: {

         'username' : username,
        'email' : email,
        'phone' : phone,
        'carStr' :carStr,
        'carInt' :carInt,

      },
    ).then((value) {
      userModel = ParkingLoginModel.fromJson(value.data);

      printFullText(userModel.data.username);

      emit(ParkingSuccessUpdateState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingErrorUpdateState());
    });
  }






}
