import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart';

@injectable
class RemoveSpotFromFavoritesUseCase implements UseCaseWithParams<void, RemoveSpotFromFavoritesParams>{
  final ShowSkateSpotsRepo repo;
  const RemoveSpotFromFavoritesUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(RemoveSpotFromFavoritesParams params) async{
    return await repo.removeSpotFromUserFavorites(spotID: params.spotID, userID: params.userID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class RemoveSpotFromFavoritesParams extends Equatable{
  final String userID;
  final String spotID;

  const RemoveSpotFromFavoritesParams({required this.spotID, required this.userID});

  @override
  List<Object> get props => [spotID, userID];

}