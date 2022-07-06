import 'package:smart_city/models/home_model.dart';

abstract class HomeStates {}
class HomeInitialState extends HomeStates{}

class ParkingLoadingHomeState extends HomeStates{}

class ParkingSuccessHomeState extends HomeStates{
  final HomeModel homeModel;

  ParkingSuccessHomeState(this.homeModel);
}

class ParkingErrorHomeState extends HomeStates {
  final String error;

  ParkingErrorHomeState(this.error);
}

class GetHomeState extends HomeStates{}
class AppChangeBottomSheetState extends HomeStates{}

class AppChangeModeState extends HomeStates{}