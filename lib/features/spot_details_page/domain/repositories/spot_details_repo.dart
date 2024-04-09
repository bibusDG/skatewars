import 'package:dartz/dartz.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/spot_details_page/domain/entities/user_comment.dart';

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

  Future<Either<Failure, void>> rateSpot({
    required String userName,
    required String comment,
    required String creationDate,
    required String spotID,
    required double userRate,
});

  Future<Either<Failure, UserComment>> getCommentByID({
    required String commentID,
});

}