import 'package:cloud_firestore/cloud_firestore.dart';

var FIREBASE_PATH = FirebaseFirestore.instance.collection('skateSpots');
var FIREBASE_USER_PATH = FirebaseFirestore.instance.collection('users');