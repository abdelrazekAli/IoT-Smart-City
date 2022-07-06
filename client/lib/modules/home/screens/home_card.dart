import 'package:flutter/material.dart';
import 'package:smart_city/shared/components/constants.dart';

class HomeCard extends StatefulWidget {
  HomeCard({
    this.size,
    this.icon,
    this.title,
    this.statusOn,
    this.statusOff,
    this.image
  });

  Size size;
  IconButton icon;
  AssetImage image;

  String title;
  String statusOn;
  String statusOff;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<HomeCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Alignment> _animation;
  bool isChecked = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _animation = Tween<Alignment>(
            begin: Alignment.bottomCenter, end: Alignment.topCenter)
        .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
        reverseCurve: Curves.easeInBack,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 160,
      width: widget.size.width * 0.35,
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
