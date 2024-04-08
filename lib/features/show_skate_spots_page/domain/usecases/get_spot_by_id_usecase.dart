import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/failure/failure.dart';
import 'package:skatewars/core/usecases/usecases.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:skatewars/features/show_skate_spots_page/domain/repositories/show_skate_spots_repo.dart';

@injectable
class GetSpotByIdUseCase implements UseCaseWithParams<SkateSpot, GetSpotByIdParams>{
  final ShowSkateSpotsRepo repo;
  const GetSpotByIdUseCase({required this.repo});

  @override
  Future<Either<Failure, SkateSpot>> call(GetSpotByIdParams params) async{
    return await repo.getSpotByID(spotID: params.spotID);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetSpotByIdParams extends Equatable{
  final String spotID;
  const GetSpotByIdParams({required this.spotID});

  @override
  List<Object> get props => [spotID];

}