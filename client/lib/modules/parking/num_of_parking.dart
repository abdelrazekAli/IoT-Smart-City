import 'package:flutter/material.dart';
import 'package:smart_city/shared/components/components.dart';

import 'Parking.dart';


class NumOfParking extends StatelessWidget {
  String city;
  NumOfParking({@required this.city,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(

    appBar: AppBar(
      title: Text('$city Parking '),

    ),
    body:SingleChildScrollView(
      child: Column(
          children: [
            ListView.separated(

              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:(context,index)=>buildChatItem(context,index),
              separatorBuilder:(context,index)=>SizedBox(
                height: 10.0,
              ),
              itemCount: 10,
            ),
          ],
        ),
      ),
  );
}



Widget buildChatItem(BuildContext context,index,) =>

 InkWell(
    onTap: (){
      navigateTo(context, Parking(model: 'Parking ${index+1}'));
    },
    child:Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(10),
        )
      ),
      child: Container(
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 45,
                    backgroundImage: AssetImage(
                      'assets/images/22.jpg',
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:  Text(
                            'Parking ${index+1}',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Row(
                      children: [

                        Text(
                          'Number Of slots : 8',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          children: [

                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                'Available : 6'
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    ),

    );

