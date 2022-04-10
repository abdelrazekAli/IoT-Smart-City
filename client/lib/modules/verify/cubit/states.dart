import 'package:smart_city/models/login_model.dart';


abstract class ParkingVerifyStates{}

class ParkingVerifyInitialState extends ParkingVerifyStates {}

class ParkingVerifyEmailLoadingState extends ParkingVerifyStates {}

class ParkingVerifyEmailSuccessState extends ParkingVerifyStates
{
  final ParkingLoginModel loginModel;

  ParkingVerifyEmailSuccessState(this.loginModel);

}

class ParkingVerifyEmailErrorState extends ParkingVerifyStates
{
  final String error;

  ParkingVerifyEmailErrorState(this.error);
}
class ParkingVerifyPassLoadingState extends ParkingVerifyStates {}

class ParkingVerifyPassSuccessState extends ParkingVerifyStates
{
  final ParkingLoginModel loginModel;

  ParkingVerifyPassSuccessState(this.loginModel);

}

class ParkingVerifyPassErrorState extends ParkingVerifyStates
{
  final String error;

  ParkingVerifyPassErrorState(this.error);
}
