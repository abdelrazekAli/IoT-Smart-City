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
class ParkingChangePasswordV2State extends ParkingRegisterStates {}

class ParkingSendOTPLoadingState extends ParkingRegisterStates {}

class ParkingSendOTPSuccessState extends ParkingRegisterStates
{
  final ParkingLoginModel loginModel;

  ParkingSendOTPSuccessState(this.loginModel);

}

class ParkingSendOTPErrorState extends ParkingRegisterStates
{
  final String error;

  ParkingSendOTPErrorState(this.error);
}

