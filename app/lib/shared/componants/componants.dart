

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';



Widget buildListTile(String title,IconData icon,Function tabHandler){
  return ListTile(
    leading:Icon(icon,size: 25,) ,

    title: Text(title,style: TextStyle(


      fontFamily: '',
      fontWeight: FontWeight.w700,
    ),),
    onTap: tabHandler,
  );
}


Widget defaultButton({
  double width = double.infinity,
  // Color background ,
  bool isUpperCase = true,
  double radius = 20.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      height: 50,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Color(0xFF014963).withOpacity(.7),
      ),
    );


Widget defaultTextButton({
  Color color,

  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          //fontSize: 21,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

Widget defaultFormField({
  List<TextInputFormatter> format,
  TextEditingController controller,
  TextInputType type,
  Function onSubmit,
  Function onTap,
  Function onChange,
  bool isPassword = false,
  Function validate,
  String label ,
  IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,

  context}) =>
    TextFormField(
      enableInteractiveSelection: true,
     inputFormatters: format,
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      enabled: isClickable,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0)
        ),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
              color: Colors.grey,
            ))
            : null,
        prefixIcon: Icon(
          prefix,
        ),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[350],
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;





}