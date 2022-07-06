import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/modules/home/custom_card.dart';
import 'package:smart_city/modules/home/screens/Garage.dart';
import 'package:smart_city/modules/home/screens/bathroom.dart';
import 'package:smart_city/modules/home/screens/bedroom.dart';
import 'package:smart_city/modules/home/screens/home_card.dart';
import 'package:smart_city/modules/home/screens/kitchen.dart';
import 'package:smart_city/modules/home/screens/livingroom.dart';
import 'package:smart_city/modules/home/screens/roof.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    int selectedCard = -1;
    RefreshController _refreshController = RefreshController();
    bool _hasInternet = false;
    ConnectivityResult result = ConnectivityResult.none;

    double temperature = 7;
    Size size = MediaQuery.of(context).size;
    Color color =HomeCubit.get(context).isDark ? Colors.black :Colors.blue;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ParkingSuccessHomeState) {
          if (state.homeModel.status) {
            var model = HomeCubit.get(context).homeModel;
            temp = model.data.degrees[0];
            gas = model.data.degrees[1];
            hum = model.data.degrees[2];
            rain = model.data.degrees[3];
          }
        }
      },
      builder: (context, state) {
        return Scaffold(


          body: SmartRefresher(

            onRefresh: () async {
              await Future.delayed(Duration(microseconds: 500));
              _refreshController.refreshFailed();
              _hasInternet = await InternetConnectionChecker().hasConnection;
              final color = _hasInternet ? Colors.green : Colors.red;

              result = await Connectivity().checkConnectivity();

              if (_hasInternet) {
                HomeCubit.get(context).getHomeData();
              }
            },
            onLoading: () async {
              await Future.delayed(Duration(microseconds: 500));
              _refreshController.refreshFailed();
            },
            //  enablePullUp: true,
            controller: _refreshController,
            child: Center(

                child: GridView.extent(

              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 7),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              maxCrossAxisExtent: 300.0,
              children: <Widget>[
                SingleChildScrollView(
                  primary: true,
                  child: InkWell(


                    child: Container(

                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Garage',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image(image: AssetImage('assets/images/garage.png'),)
                          ],
                        ),
                      ),

                    ),
                    onTap: (){
                      navigateTo(context, Garage());
                    },
                  ),
                ),
                InkWell(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Living Room',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(image: AssetImage('assets/images/Webp.net-resizeimage (1).png'))
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    navigateTo(context, LivingRoom());
                  },
                ),
                SingleChildScrollView(
                  child: InkWell(
                    child: Container(
                      decoration:  BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Kitchen',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(image: AssetImage('assets/images/kitchen.png'))
                        ],
                      ),
                    ),
                    onTap: (){
                      navigateTo(context, Kitchen());
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Bathroom',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image(image: AssetImage('assets/images/bathroom.png'))
                        ],
                      ),
                    ),
                    onTap: (){
                      navigateTo(context, BathRoom());
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            'Bed Room',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         Image(image: AssetImage('assets/images/Webp.net-resizeimage.png'))
                        ],
                      ),
                    ),
                    onTap: (){
                      navigateTo(context, BedRoom());
                    },
                  ),
                ),
                SingleChildScrollView(
                  primary: true,
                  child: InkWell(


                    child: Container(

                      decoration: BoxDecoration(
                        color: kBgColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(3, 3),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 0,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Roof',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Image(image: AssetImage('assets/images/stairs.png'),)
                          ],
                        ),
                      ),

                    ),
                    onTap: (){
                      navigateTo(context, Roof());
                    },
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}

