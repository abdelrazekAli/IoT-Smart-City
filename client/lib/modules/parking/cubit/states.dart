import 'package:smart_city/models/parking_model.dart';

abstract class SlotsStates {}

class SlotsInitialState extends SlotsStates{}

class ParkingLoadingSlotsState extends SlotsStates{}

class ParkingSuccessSlotsState extends SlotsStates{
 final ParkingSlotsModel slotsModel;

  ParkingSuccessSlotsState(this.slotsModel);
}

class ParkingErrorSlotsState extends SlotsStates {
  final String error;

  ParkingErrorSlotsState(this.error);
}

class GetSlotsState extends SlotsStates{}