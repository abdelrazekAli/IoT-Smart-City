
import 'package:flutter/cupertino.dart';

class ParkingLoginModel
{
  bool status;
  String message;
  UserData data;

  ParkingLoginModel.fromJson(Map<String,dynamic> json)
  {
    status =json['status'];
    message =json['message'];
    data =json['data'] !=null? UserData.fromJson(json['data']): null;


  }

}
class UserData
{
  String uid;
  String username;
  String email;
  String password;
  String token;
  String phone;
  String carStr;
  String carInt;




  UserData.fromJson(Map<String,dynamic> json)
  {

    uid =json['_id'];
    username =json['username'];
    email =json['email'];
    password=json['password'];
    phone =json['phone'];
    token =json['token'];
    carStr=json['carStr'];
    carInt=json['carInt'];




  }
}
