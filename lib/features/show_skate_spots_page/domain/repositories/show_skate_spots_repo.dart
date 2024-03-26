import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class ShowSkateSpotsRepo{
  const ShowSkateSpotsRepo();

  Future<Either<Failure, Stream<List<SkateSpot>>>> streamSkateSpots({
    required String distance,
});

}