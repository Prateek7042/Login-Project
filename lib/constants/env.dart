
import 'package:flutter/material.dart';

class Env{

  //Snack Bar message
  static snackBar(context,String content){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Text(content)));
  }

  //Push and remove previous routes
  static gotoReplacement(context,Widget route){
    Navigator.of(context).popUntil((route) => false);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
  }

  //Simple Navigator
  static goto(context,Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>route));
  }

}