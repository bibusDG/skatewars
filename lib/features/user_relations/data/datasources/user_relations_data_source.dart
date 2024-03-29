import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';

abstract class UserRelationsDataSource{
  const UserRelationsDataSource();

  Future<Position> getUserCurrentPosition();

  Future<String> loginUserWithEmail({
    required String userLoginEmail,
    required String userPassword,
});

  Future<UserCredential> loginWithGoogle();

  Future<void> logOutUser();

  Stream<User?> userIsLoggedIn();

  Future<void> deleteUserFromDataBase({
    required String userID,
});

  Future<void> registerNewUser({
    required String userEmail,
    required String userPassword,
    required String userName,
    required String userSureName,
    required String userAvatar,
    required String userMobileToken,
    required String userID,
    required List<String> favouriteSpots,
    required int skatePoints,
    required int skateWarsWon,
    required int skateWarsLost,
});

}
@Singleton(as: UserRelationsDataSource)
class UserRelationsDataSourceImp implements UserRelationsDataSource{
  @override
  Future<Position> getUserCurrentPosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
    // TODO: implement getUserCurrentPosition
    throw UnimplementedError();
  }

  @override
  Future<void> logOutUser() async{
    ///logout from google if user loggedIn with google
    GoogleSignIn googleSignIn = GoogleSignIn();
    final _isSignedInViaGoogle = await googleSignIn.isSignedIn();
    if(_isSignedInViaGoogle == true){
      await googleSignIn.signOut();
    }
    await FirebaseAuth.instance.signOut();

    ///set user status to logOut
    await setUserLoggInStatus();
    // TODO: implement logOutUser
    // throw UnimplementedError();
  }

  @override
  Future<String> loginUserWithEmail({required String userLoginEmail, required String userPassword}) async{
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: userLoginEmail, password: userPassword);
    return result.user!.uid;
    // TODO: implement loginUserWithCredentials
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> loginWithGoogle() async{
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final googleCredentials = GoogleAuthProvider.credential(
      idToken:googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final credentials = await FirebaseAuth.instance.signInWithCredential(googleCredentials);
    ///set user status to loggedIN
    await setUserLoggInStatus();
    ///
    return credentials;
    // TODO: implement loginWithGoogle
    // throw UnimplementedError();
  }

  @override
  Future<void> registerNewUser({
    required String userEmail,
    required String userPassword,
    required String userName,
    required String userSureName,
    required String userAvatar,
    required String userMobileToken,
    required String userID,
    required List<String> favouriteSpots,
    required int skatePoints,
    required int skateWarsWon,
    required int skateWarsLost,
  }) async{
    final result = await FIREBASE_USER_PATH.add(
        MyUser(userEmail: userEmail,
            userPassword: userPassword,
            userName: userName,
            userSureName: userSureName,
            userAvatar: userAvatar,
            userMobileToken: userMobileToken,
            userID: userID,
            favouriteSpots: favouriteSpots,
            skatePoints: skatePoints,
            skateWarsWon: skateWarsWon,
            skateWarsLost: skateWarsLost).toJson());
    final uid = result.id;
    final userToken = await FirebaseMessaging.instance.getToken();
    await FIREBASE_USER_PATH.doc(uid).update({'userID': uid, 'userMobileToken': userToken});
    // TODO: implement registerNewUser
    // throw UnimplementedError();
  }

  @override
  Future<void> deleteUserFromDataBase({required String userID}) async{
    await FIREBASE_USER_PATH.doc(userID).delete();
    // TODO: implement deleteUserFromDataBase
    // throw UnimplementedError();
  }

  @override
  Stream<User?> userIsLoggedIn() async*{
    yield* FirebaseAuth.instance.authStateChanges();
    // TODO: implement userIsLoggedIn
    // throw UnimplementedError();
  }

}