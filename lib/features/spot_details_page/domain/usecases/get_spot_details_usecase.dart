import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';

@injectable
class GetSpotDetailsUseCase implements UseCaseWithParams<Stream<SkateSpot>, GetSpotDetailsParams>{
  final SpotDetailsRepo repo;
  const GetSpotDetailsUseCase({required this.repo});

  @override
  Future<Either<Failure, Stream<SkateSpot>>> call(GetSpotDetailsParams params) async{
    return await repo.getSpotDetails(spotID: params.spotID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetSpotDetailsParams extends Equatable{
  final String spotID;
  const GetSpotDetailsParams({required this.spotID});

  @override
  List<Object> get props => [spotID];

}