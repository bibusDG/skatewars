import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failure/failure.dart';

abstract class UserRelationsRepo {
  const UserRelationsRepo();

  Future<Either<Failure, Position>> getUserCurrentPosition();

//   Future<Either<Failure, void>> loginUser({
//     required String userLoginEmail,
//     required String userPassword,
// });
//
//   Future<Either<Failure, void>> logOutUser();
//
//   Future<Either<Failure, void>> registerNewUser({
//     required String userEmail,
//     required String userPassword,
// });

}