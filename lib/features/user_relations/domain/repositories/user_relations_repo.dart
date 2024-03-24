import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failure/failure.dart';

abstract class UserRelationsRepo {
  const UserRelationsRepo();

  Future<Either<Failure, Position>> getUserCurrentPosition();

}