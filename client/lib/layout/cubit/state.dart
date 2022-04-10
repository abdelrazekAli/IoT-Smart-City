

import 'package:smart_city/models/login_model.dart';

abstract class ParkingStates {}

class ParkingInitialStates extends ParkingStates {}

class ParkingChangeBottomNavStates extends ParkingStates {}

class ParkingLoadingHomeDataState extends ParkingStates{}

class ParkingSuccessHomeDataState extends ParkingStates{}

class ParkingErrorHomeDataState extends ParkingStates {}

class ParkingSuccessCategoriesState extends ParkingStates{}

class ParkingErrorCategoriesState extends ParkingStates {}

class ParkingSuccessChangeFavoritesState extends ParkingStates
{
/*  final ChangeFavModel model;

  ParkingSuccessChangeFavoritesState(this.model);*/

}

class ParkingChangeFavoritesState extends ParkingStates{}

class ParkingErrorChangeFavoritesState extends ParkingStates {}

class ParkingLoadingGetFavoritesState extends ParkingStates{}

class ParkingSuccessGetFavState extends ParkingStates{

}

class ParkingErrorGetFavState extends ParkingStates {}

class ParkingLoadingUserDataState extends ParkingStates{}

class ParkingSuccessUserDataState extends ParkingStates{

  final ParkingLoginModel loginModel;

  ParkingSuccessUserDataState(this.loginModel);
}

class ParkingErrorUserDataState extends ParkingStates {}

class ParkingLoadingUpdateState extends ParkingStates{}

class ParkingSuccessUpdateState extends ParkingStates{

  final ParkingLoginModel loginModel;

  ParkingSuccessUpdateState(this.loginModel);
}

class ParkingErrorUpdateState extends ParkingStates {}









