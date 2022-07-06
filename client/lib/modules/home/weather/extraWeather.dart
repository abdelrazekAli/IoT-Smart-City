import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:weather_icons/weather_icons.dart';

class ExtraWeather extends StatelessWidget {

  ExtraWeather();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Column(
              children: [
                Icon(
                  CupertinoIcons.wind,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                   "$hum %",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Humidity",
                  style: TextStyle(color: Colors.black54, fontSize: 30),
                )
              ],
            ),
           /* Column(
              children: [
                Icon(
                  WeatherIcons.rain,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  temp.chanceRain.toString() + " %",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rain",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                )
              ],
            )*/
          ],
        ) ;
      },

    );
  }
}
