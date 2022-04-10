class ParkingSlotsModel {
  bool status;
  String message;
  Data data;

  ParkingSlotsModel({this.status, this.message, this.data});

  ParkingSlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<int> slots;

  Data({this.slots});

  Data.fromJson(Map<String, dynamic> json) {
    slots = json['slots'].cast<int>();
  }
}