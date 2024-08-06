import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customSnackBar(BuildContext context,String Msg,bool showIcon,Color? textColor){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Visibility(
               visible: showIcon,
               child: Icon(Icons.error_outlined,color:textColor?? Colors.red,size: 25,)),
          Text(
            Msg,
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      margin: EdgeInsets.all(2),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds:10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 10,
      backgroundColor:Colors.white,
    ),
  );
}