import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/layout_screen.dart';
import 'package:smart_city/models/login_model.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/modules/on_boarding/on_boarding_screen.dart';
import 'package:smart_city/modules/parking/cubit/cubit.dart';
import 'package:smart_city/shared/bloc_observer.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/cubit/cubit.dart';
import 'package:smart_city/shared/cubit/states.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = await CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = await CacheHelper.getData(key: 'onBoarding');
  token = await CacheHelper.getData(key: 'token');
  uid = await CacheHelper.getData(key: 'uid');
  username = await CacheHelper.getData(key: 'username');
  email = await CacheHelper.getData(key: 'email');
  phone = await CacheHelper.getData(key: 'phone');
  carStr = await CacheHelper.getData(key: 'carStr');
  carInt = await CacheHelper.getData(key: 'carInt');

  if (onBoarding != null) {
    if (token != null)
      widget = LayoutScreen();
    else
      widget = ParkingLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
  final MqttServerClient client =MqttServerClient('server', 'id');
  String statusText = "Status Text";
  Future<UserData> futureData;

  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("c6218e1e-82ad-420b-bcad-3d626af97d6d");
  }

  Widget build(BuildContext context) {

    final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier(ThemeMode.light);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: widget.isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..changeAppMode(
              fromShared: widget.isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => ParkingCubit()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SlotsCubit()..getSlotsData()),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()..getHomeData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder: (_, ThemeMode currentMode, __) {
                return OverlaySupport.global(
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(primarySwatch: Colors.blue,
                   // primaryColor: Colors.blue
                    ),
                    darkTheme: ThemeData.dark(),
                    themeMode: AppCubit.get(context).isDark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                    home: widget.startWidget,
                  ),
                );
              },
            );
          }),
    );

  }
  connect(){}

  disconnect(){}


  Future<bool> mqttConnect(String uniqueId) async{
    setStatus("Connecting MQTT Broker");
    ByteData rootCA = await rootBundle.load('assets/certs/RootCA.pem');
    ByteData deviceCert = await rootBundle.load('assets/certs/DeviceCertificate.crt');
    ByteData privateKey = await rootBundle.load('assets/certs/Private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

    client.securityContext =context;
    client.logging(on: true);
    client.keepAlivePeriod=20;
    client.port =8883;
    client.secure =true;
    client.onConnected = onConnected;
    client.onDisconnected= onDisconnected;
    client.pongCallback =pong;
    final MqttConnectMessage connMess = MqttConnectMessage().withClientIdentifier(uniqueId).startClean();
    client.connectionMessage =connMess;
    await client.connect();
    if( client.connectionStatus.state ==MqttConnectionState.connected){
      print("Connected to AWS Successfully!");
    }else{
      return false;
    }
    const topic = 'esp32/cam_0';
    client.subscribe(topic, MqttQos.atMostOnce);
    return true;
  }
  void setStatus(String content){
    setState(() {
      statusText = content;
    });
  }
  void onConnected(){
    setStatus('Client connection was successful');
  }
  void onDisconnected(){
    setStatus('Client connection was failed');

  }
  void pong(){
    setStatus('Ping response  Client callback invoked');

  }

}