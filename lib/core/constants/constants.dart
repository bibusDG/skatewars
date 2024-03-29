import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

var FIREBASE_PATH = FirebaseFirestore.instance.collection('skateSpots');
var FIREBASE_USER_PATH = FirebaseFirestore.instance.collection('users');

StreamController<bool> userLoggedIn = StreamController<bool>();

var USER_LOGGED_IN = false;
Future<void> setUserLoggInStatus() async{
  if(USER_LOGGED_IN == true){
    USER_LOGGED_IN = false;
  }else{
    USER_LOGGED_IN = true;
  }
}