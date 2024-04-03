import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/spot_details_page/domain/repositories/spot_details_repo.dart';

@injectable
class AddUserToSpotUseCase implements UseCaseWithParams<void, AddUserToSpotParams>{
  final SpotDetailsRepo repo;
  const AddUserToSpotUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(AddUserToSpotParams params) async{
    return await repo.addUserToSpot(userID: params.userID, spotID: params.spotID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddUserToSpotParams extends Equatable{
  final String userID;
  final String spotID;
  const AddUserToSpotParams({required this.spotID, required this.userID});

  @override
  List<Object> get props => [userID, spotID];
}