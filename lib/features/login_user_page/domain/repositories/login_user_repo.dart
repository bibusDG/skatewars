import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/failure/failure.dart';

abstract class LoginUserRepo {
  const LoginUserRepo();

  Future<Either<Failure, Position>> getUserCurrentPosition();

}