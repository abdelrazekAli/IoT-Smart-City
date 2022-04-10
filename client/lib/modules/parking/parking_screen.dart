import 'package:flutter/material.dart';
import 'package:smart_city/shared/components/components.dart';

import 'Search_Screen.dart';
import 'num_of_parking.dart';

class ParkingScreen extends StatelessWidget {
  var newController = TextEditingController();
  final List<String> cites = <String>[
    'Cairo',
    'Cardiff',
    'Dierb Negm',
    'El3slogy',
    'Ela7asania',
    'Giza',
    'Hamburg',
    'Kafr Saqr',
    'London',
    'Lisbon',
    'Madrid',
    'Manchester',
    'Munich',
    'Milan',
    'Paris',
  ];


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        children: [
          Container(

              child: Padding(
                padding: EdgeInsets.only(left:size.height*.0246,right:size.height*.001 ),
                child: Row(
                  children: [
                    /* SizedBox(
                      width: 12,
                    ),*/
                    InkWell(
                      onTap: () async {
                        showSearch(
                            context: context, delegate: CitySearch());

                        final results = await showSearch(
                            context: context, delegate: CitySearch());

                        print('Result: $results');
                      },
                      child: Container(
                        width: size.width*.9,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 242, 232, 232),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(10),
                            )
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Text(
                                'Search ...',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.grey[500],
                                  ),
                                  onPressed: () async {
                                    showSearch(
                                        context: context,
                                        delegate: CitySearch());

                                    final results = await showSearch(
                                        context: context,
                                        delegate: CitySearch());

                                    print('Result: $results');
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(child:
          SingleChildScrollView(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  buildChatItem(cites[index], context, index),
              separatorBuilder: (context, index) => SizedBox(
                height: 2.0,
              ),
              itemCount: cites.length,
            ),
          ),
          )

        ],
      ),
    );
  }
}

Widget buildChatItem(
    String city,
    BuildContext context,
    index,
    ) =>
    InkWell(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      onTap: () {
        navigateTo(
            context,
            NumOfParking(
              city: city,
            ));
      },
      child:Padding(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(10),
              )),
          color: Colors.blueGrey[300],
          child: Padding(
            padding: EdgeInsets.only(top: 12,left: 10,bottom: 12),
            child: Container(
              child: Row(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 36,
                        backgroundImage: AssetImage('assets/images/1.jpeg'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '$city',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Number Of Parking : 10',
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Container(
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Available : 7'),
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
            ),
          ),
        ) ,
      ),
    );