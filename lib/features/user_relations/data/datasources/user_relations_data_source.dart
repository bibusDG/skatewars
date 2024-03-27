import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class UserRelationsDataSource{
  const UserRelationsDataSource();

  Future<Position> getUserCurrentPosition();

  Future<String> loginUserWithEmail({
    required String userLoginEmail,
    required String userPassword,
});

  Future<void> loginWithGoogle();

  Future<void> logOutUser();

  Future<void> registerNewUser({
    required String userEmail,
    required String userPassword,
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
    await FirebaseAuth.instance.signOut();
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
  Future<void> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> registerNewUser({required String userEmail, required String userPassword}) {
    // TODO: implement registerNewUser
    throw UnimplementedError();
  }

}