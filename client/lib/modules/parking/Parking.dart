import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/modules/parking/cubit/cubit.dart';
import 'package:smart_city/modules/parking/cubit/states.dart';
import 'package:smart_city/shared/components/components.dart';
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
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<SlotsCubit, SlotsStates>(
        listener: (context, state) {
          if(state is ParkingSuccessSlotsState){
            var model = SlotsCubit.get(context).slotsModel;
            slots1= model.data.slots[0] ;
            slots2 = model.data.slots[1] ;
            slots3 = model.data.slots[2] ;
            slots4=model.data.slots[3] ;
            slots5=model.data.slots[4] ;
            slots6=model.data.slots[5] ;
          }else
            print('Can\'t get slots');
        },
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text('${widget.model.toString()} '),
            ),
            body: Form(
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
                        top: size.height * .246,
                        start: size.width * .28,
                        child: Transform.rotate(
                          angle: 0 * pi / 180,
                          child: Container(
                            width: size.width * .235,
                            height: size.height * .185,
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
                        top: size.height * .36,
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
                        bottom: size.height * .286,
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
                        bottom: size.height * .256,
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
                        top: size.height * .31,
                        end: size.width * .27,
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
                        bottom: size.height * .20,
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
          );
        });
  }
}
