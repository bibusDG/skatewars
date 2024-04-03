import 'package:dartz/dartz.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

import '../../../../core/failure/failure.dart';

abstract class SpotDetailsRepo{
  const SpotDetailsRepo();

  Future<Either<Failure, Stream<SkateSpot>>> getSpotDetails({
    required String spotID,
});

  Future<Either<Failure, void>> addUserToSpot({
    required String userID,
    required String spotID,
});

  Future<Either<Failure, void>> removeUserFromSpot({
    required String userID,
    required String spotID,
});

}