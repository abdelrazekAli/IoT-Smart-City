class HomeModel {
  bool status;
  String message;
  Data data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<int> degrees;

  Data({this.degrees});

  Data.fromJson(Map<String, dynamic> json) {
    degrees = json['degrees'].cast<int>();
  }

}