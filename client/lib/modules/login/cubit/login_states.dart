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
class ParkingChangePasswordV1State extends ParkingLoginStates {}
class ParkingChangePasswordV2State extends ParkingLoginStates {}
class ParkingChangePasswordV3State extends ParkingLoginStates {}


class ParkingChangePasswordLoadingState extends ParkingLoginStates {}


class ParkingChangePasswordSuccessState extends ParkingLoginStates {

  final ParkingLoginModel passwordModel;

  ParkingChangePasswordSuccessState(this.passwordModel);
}

class ParkingChangePasswordErrorState extends ParkingLoginStates {

  final String error;

  ParkingChangePasswordErrorState(this.error);
}
class ParkingNewPasswordLoadingState extends ParkingLoginStates {}


class ParkingNewPasswordSuccessState extends ParkingLoginStates {

  final ParkingLoginModel passwordModel;

  ParkingNewPasswordSuccessState(this.passwordModel);
}

class ParkingNewPasswordErrorState extends ParkingLoginStates {

  final String error;

  ParkingNewPasswordErrorState(this.error);
}






