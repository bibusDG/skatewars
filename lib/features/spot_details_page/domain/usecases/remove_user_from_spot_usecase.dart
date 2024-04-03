import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';

@injectable
class RemoveUserFromSpotUseCase implements UseCaseWithParams<void, RemoveUserFromSpotParams>{
  final SpotDetailsRepo repo;
  const RemoveUserFromSpotUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RemoveUserFromSpotParams params) async{
    return await repo.removeUserFromSpot(userID: params.userID, spotID: params.spotID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class RemoveUserFromSpotParams extends Equatable{
  final String userID;
  final String spotID;

  const RemoveUserFromSpotParams({required this.spotID, required this.userID});

  @override
  List<Object> get props => [userID, spotID];
}