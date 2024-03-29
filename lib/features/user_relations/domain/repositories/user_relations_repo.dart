import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failure/failure.dart';

abstract class UserRelationsRepo {
  const UserRelationsRepo();

  Future<Either<Failure, Position>> getUserCurrentPosition();

  Future<Either<Failure, String>> loginUserWithEmail({
    required String userLoginEmail,
    required String userPassword,
});

  Future<Either<Failure, void>> logOutUser();

  Future<Either<Failure, void>> deleteUserFromDataBase({
    required String userID,
});

  Future<Either<Failure, void>> registerNewUser({
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

  Future<Either<Failure, UserCredential>> loginWithGoogle();

}