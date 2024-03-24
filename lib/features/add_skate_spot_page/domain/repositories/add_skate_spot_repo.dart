import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../user_relations/domain/entities/my_user.dart';

abstract class AddSkateSpotRepo{
  const AddSkateSpotRepo();

  Future<Either<Failure, void>> addSkateSpot({
    required String spotName,
    required String spotDescription,
    required String spotLat,
    required String spotLang,
    required List<String> spotPhotos,
    required List<double> spotRanks,
    required List<String> spotProperties,
    required String spotID,
    required List<MyUser> spotRiders,
    required List<String> spotComments,
});
}

