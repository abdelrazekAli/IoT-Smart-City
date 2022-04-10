import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/register/register_screen.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/network/cache_helper.dart';


void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ParkingLoginScreen(),
      );
    }
  });
}



void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
var uid = '';
String username='';
String email='';
String phone='';
String carStr='';
String carInt='';
String oldPassword='';
String newPassword='';
var slots1;
var slots2;
var slots3;
var slots4;
var slots5;
var slots6;

