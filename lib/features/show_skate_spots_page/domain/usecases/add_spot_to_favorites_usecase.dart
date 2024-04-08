import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart';

@injectable
class AddSpotToFavoritesUseCase implements UseCaseWithParams<void, AddSpotToFavoritesParams>{
  final ShowSkateSpotsRepo repo;
  const AddSpotToFavoritesUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(AddSpotToFavoritesParams params) async{
    return await repo.addSpotToUserFavorites(spotID: params.spotID, userID: params.userID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddSpotToFavoritesParams extends Equatable{
  final String userID;
  final String spotID;

  const AddSpotToFavoritesParams({required this.spotID, required this.userID});

  @override
  List<Object> get props => [userID, spotID];

}