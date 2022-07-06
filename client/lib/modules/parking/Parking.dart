import 'dart:math';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_city/modules/parking/cubit/cubit.dart';
import 'package:smart_city/modules/parking/cubit/states.dart';
import 'package:smart_city/shared/components/constants.dart';


class Parking extends StatefulWidget {
  final String model;
  Parking({@required this.model});

  @override
  State<Parking> createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = RefreshController();
    bool _hasInternet =false;
    ConnectivityResult result = ConnectivityResult.none;
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<SlotsCubit, SlotsStates>(
        listener: (context, state) {

          if(state is ParkingSuccessSlotsState){
            var model = SlotsCubit.get(context).slotsModel;
           var slots={
           slots1= model.data.slots[0] ,
            slots2 = model.data.slots[1] ,
            slots3 = model.data.slots[2] ,
            slots4=model.data.slots[3] ,
            slots5=model.data.slots[4] ,
            slots6=model.data.slots[5] ,
           };
           if (slots != slots){
             SlotsCubit.get(context).getSlotsData();
           }
          }else
            print('Can\'t get slots');
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text('1 '),
            ),
            body: SmartRefresher(


              onRefresh:() async {
                await Future.delayed(Duration(microseconds: 500));
                _refreshController.refreshFailed();
                //Restart.restartApp();

                _hasInternet=await InternetConnectionChecker().hasConnection ;
                final color = _hasInternet ? Colors.green :Colors.red;

                result= await Connectivity().checkConnectivity();

                if(_hasInternet){
                  SlotsCubit.get(context).getSlotsData();

                }



              },
              onLoading:() async {
                await Future.delayed(Duration(microseconds: 500));
                _refreshController.refreshFailed();
              },
              //  enablePullUp: true,
              controller: _refreshController,
              child: Form(
                key: formKey,
                child: Stack(

                  children: [
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/p1.jpeg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    PositionedDirectional(
                      bottom: 10,
                      start: 170,
                      child: Text(
                        'Entry',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    //Car1


                    if (slots1 != 1)
                      PositionedDirectional(
                          top: size.height * .280,
                          start: size.width * .28,
                          child: Transform.rotate(
                            angle: 0 * pi / 180,
                            child: Container(
                              width: size.width * .240,
                              height: size.height * .190,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/c2.png',
                                    ),
                                  )),
                            ),
                          )),

                    //Car2
                    if (slots2 != 1)
                      PositionedDirectional(
                          top: size.height * .405,
                          start: size.width * .30,
                          child: Transform.rotate(
                            angle: 90 * pi / 180,
                            child: Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/c3.png',
                                    ),
                                  )),
                            ),
                          )),

                    //Car3
                    if (slots3 != 1)
                      PositionedDirectional(
                          bottom: size.height * .330,
                          start: size.width * .247,
                          child: Transform.rotate(
                            angle: 90 * pi / 180,
                            child: Container(
                              width: 125,
                              height: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/123.png',
                                    ),
                                  )),
                            ),
                          )),

                    //Car4
                    if (slots4 != 1)
                      PositionedDirectional(
                          bottom: size.height * .295,
                          end: size.width * .28,
                          child: Transform.rotate(
                            angle: 270 * pi / 180,
                            child: Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/c5.png',
                                    ),
                                  )),
                            ),
                          )),

                    //Car5
                    if (slots5 != 1)
                      PositionedDirectional(
                          top: size.height * .353,
                          end: size.width * .25,
                          child: Transform.rotate(
                            angle: 270 * pi / 180,
                            child: Container(
                              width: 120,
                              height: 125,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/c62.png',
                                    ),
                                  )),
                            ),
                          )),
                    //Car6
                    if (slots6 != 1)
                      PositionedDirectional(
                          bottom: size.height * .240,
                          start: size.width * .23,
                          child: Transform.rotate(
                            angle: 0 * pi / 180,
                            child: Container(
                              width: 125,
                              height: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/c4.png',
                                    ),
                                  )),
                            ),
                          )),

                    PositionedDirectional(
                        top: 20,
                        start: 170,
                        child: Text(
                          'EXIT',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }



}