import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/parking_model.dart';
import 'package:smart_city/modules/parking/cubit/states.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';



class SlotsCubit extends Cubit<SlotsStates> {
  SlotsCubit() : super((SlotsInitialState()));


  static SlotsCubit get(context) => BlocProvider.of(context);


  ParkingSlotsModel slotsModel;

  void getSlotsData() {
    emit(ParkingLoadingSlotsState());

    DioHelper.getData(
      url: parking_slots,
      token: token,

    ).then((value) {
      slotsModel = ParkingSlotsModel.fromJson(value.data);
      printFullText(slotsModel.data.slots.toString());

      emit(ParkingSuccessSlotsState(slotsModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingErrorSlotsState(error.toString()));
    });
  }

}




