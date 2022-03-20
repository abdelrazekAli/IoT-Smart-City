
import 'package:flutter/material.dart';
import 'package:smart_city/modules/book_details.dart';



class ParkingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),

                  ),
                  width: MediaQuery.of(context).size.width / 3,

                  child: Divider(
                    color: Colors.black45,
                    thickness: 15 ,
                  ),

                ),
                Container(

                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: Text(
                      'EXIT',style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),

                  ),
                  width: MediaQuery.of(context).size.width / 3,

                  child: Divider(
                    color: Colors.black45,
                    thickness: 15 ,
                  ),

                ),
              ],
            ),
            Container(
              height: 620,
              child: GridView.builder(

                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => itemCard(
                  onTap:() =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetails(
                          ),
                        ),
                      ), context: context,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),

                  ),
                  width: MediaQuery.of(context).size.width / 3,

                  child: Divider(
                    color: Colors.black45,
                    thickness: 15 ,
                  ),

                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: Text(
                      'ENTRY',style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),

                  ),
                  width: MediaQuery.of(context).size.width / 3,

                  child: Divider(
                    color: Colors.black45,
                    thickness: 15 ,
                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


Widget itemCard({context,required , @required Future Function() onTap})=>GestureDetector(
onTap: onTap,
child:  Row(

children: [

  SizedBox(width: 32,),

Container(


decoration: BoxDecoration(

borderRadius: BorderRadius.circular(25),

color: Colors.blue,

),



width: MediaQuery.of(context).size.width /3,

height: MediaQuery.of(context).size.height /5,



),

],

)
);
