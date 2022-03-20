

import 'package:smart_city/models/login_model.dart';

abstract class ParkingRegisterStates{}

class ParkingRegisterInitialState extends ParkingRegisterStates {}

class ParkingRegisterLoadingState extends ParkingRegisterStates {}

class ParkingRegisterSuccessState extends ParkingRegisterStates
{
  final ParkingLoginModel loginModel;

  ParkingRegisterSuccessState(this.loginModel);

}

class ParkingRegisterErrorState extends ParkingRegisterStates
{
  final String error;

  ParkingRegisterErrorState(this.error);
}
class ParkingChangePasswordVState extends ParkingRegisterStates {}
