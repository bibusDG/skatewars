import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';

@injectable
class RateSpotUseCase implements UseCaseWithParams<void, RateSpotParams>{
  final SpotDetailsRepo repo;
  const RateSpotUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RateSpotParams params) async{
    return await repo.rateSpot(
        userName: params.userName,
        comment: params.comment,
        creationDate: params.creationDate,
        spotID: params.spotID,
        userRate: params.userRate);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class RateSpotParams extends Equatable{
  final String userName;
  final String comment;
  final String creationDate;
  final double userRate;
  final String spotID;

  const RateSpotParams({
    required this.spotID,
    required this.userName,
    required this.comment,
    required this.creationDate,
    required this.userRate,
});

  @override
  List<Object> get props => [comment, spotID, userRate, userName];

}