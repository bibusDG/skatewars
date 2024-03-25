import 'package:flutter/material.dart';

class CustomSnackBar{
  mySnackBar(context, message){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.tealAccent,
          elevation: 20.0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            content: Text(message)));
  }
}