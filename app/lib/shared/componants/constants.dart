import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/register/register_screen.dart';
import 'package:smart_city/shared/componants/componants.dart';
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

void addAcount(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateTo(
        context,
        ParkingRegisterScreen(),
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