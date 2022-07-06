import 'package:flutter/material.dart';
import 'package:smart_city/modules/login/parking_login_screen.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_2.png',
      title: 'Internet of Things',
      body: '     With IoT Everything is Connected.',
    ),BoardingModel(
      image: 'assets/images/onboard_1.png',
      title: 'Welcome to your Smart City',
      body: '     We made everything Smart for you \n     Let\'s live easier..',
    ),
    BoardingModel(
      image: 'assets/images/onboard_3.png',
      title: 'Smart Parking',
      body: '     By connecting to the network,\n     You can easily find out\n     the nearest Parking to you...',
    ),
    BoardingModel(
      image: 'assets/images/onboard.png',
      title: 'Smart Home',
      body: '     You can find out if your home\n is in danger through us\n     from anywhere....',
    ),
    BoardingModel(
      image: 'assets/images/onboard_4.png',
      title: 'Explore New Place For You',
      body: '      Come on.\n      You can know more about\n your smart city,\n      let\'s check it out.....',
    ),
  ];
  bool isLast =false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, ParkingLoginScreen(),);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(

              onPressed: (){
                submit();
              },
              child: Text('SKIP',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
                ,))


        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:  boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      isLast=true;
                    });
                  }else
                  {

                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics:  BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 3,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}',),

          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
