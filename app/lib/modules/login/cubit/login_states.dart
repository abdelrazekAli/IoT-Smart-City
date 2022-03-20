import 'package:smart_city/models/login_model.dart';

abstract class ParkingLoginStates{}

class ParkingLoginInitialState extends ParkingLoginStates {}

class ParkingLoginLoadingState extends ParkingLoginStates {}

class ParkingLoginSuccessState extends ParkingLoginStates
{
  final ParkingLoginModel loginModel;

  ParkingLoginSuccessState(this.loginModel);

}

class ParkingLoginErrorState extends ParkingLoginStates
{
  final String error;

  ParkingLoginErrorState(this.error);
}
class ParkingChangePasswordState extends ParkingLoginStates {}
