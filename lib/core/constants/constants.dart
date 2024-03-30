import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';

var FIREBASE_PATH = FirebaseFirestore.instance.collection('skateSpots');
var FIREBASE_USER_PATH = FirebaseFirestore.instance.collection('users');

var USER_LOGGED_IN = false;
MyUser LOGGED_USER = MyUser.empty();

// MyUser userByID = MyUser(
//     userEmail: userEmail,
//     userPassword: userPassword,
//     userName: userName,
//     userSureName: userSureName,
//     userAvatar: userAvatar,
//     userMobileToken: userMobileToken,
//     userID: userID,
//     favouriteSpots: favouriteSpots,
//     skatePoints: skatePoints,
//     skateWarsWon: skateWarsWon,
//     skateWarsLost: skateWarsLost)
// Future<void> setUserLoggInStatus() async{
//   if(USER_LOGGED_IN == true){
//     USER_LOGGED_IN = false;
//   }else{
//     USER_LOGGED_IN = true;
//   }
// }