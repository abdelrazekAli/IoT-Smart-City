import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/login/cubit/login_states.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/on_boarding/on_boarding_screen.dart';
import 'package:smart_city/shared/bloc_observer.dart';
import 'package:smart_city/shared/componants/constants.dart';
import 'package:smart_city/shared/cubit/cubit.dart';
import 'package:smart_city/shared/cubit/states.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/shared/network/dio_helper.dart';

import 'package:http/http.dart' as http;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');


  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  uid= CacheHelper.getData(key: 'uid');

  if (onBoarding != null) {
    if (token != null)
      widget = LayoutScreen();
    else
      widget = ParkingLoginScreen();

  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatefulWidget {

  final bool isDark;
  final Widget startWidget;


  const MyApp({this.isDark, this.startWidget});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<UserData> futureData;

  @override
  void initState(){
    super.initState();
   /* futureData= fetchData();*/
  }


  Widget build(BuildContext context) {
     final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);
    return MultiBlocProvider(

      providers:[
      BlocProvider(
        create: (BuildContext context)=> AppCubit()
          ..changeAppMode(
            fromShared: widget.isDark,
          ),
    ),
        BlocProvider(
            create: (BuildContext context)=> ParkingCubit()..getUserData()

        ),

        ],
        child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
         builder: (context, state) {
          return ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder:(_,ThemeMode currentMode, __) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.blueGrey),
                darkTheme: ThemeData.dark(),
                themeMode: AppCubit.get(context).isDark
              ? ThemeMode.light
                  : ThemeMode.dark,

                home: widget.startWidget,
              );
            },
          );
    }
        ),
      );



  }
}

