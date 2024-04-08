import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class ShowSkateSpotsRepo{
  const ShowSkateSpotsRepo();

  Future<Either<Failure, Stream<List<SkateSpot>>>> streamSkateSpots({
    required String distance,
});

  Future<Either<Failure, void>> addSpotToUserFavorites({
    required String spotID,
    required String userID,
  });

  Future<Either<Failure, void>> removeSpotFromUserFavorites({
    required String spotID,
    required String userID,
  });

  Future<Either<Failure, SkateSpot>> getSpotByID({
    required String spotID,
});

}