import 'package:dartz/dartz.dart';
import '../../../user_relations/domain/entities/my_user.dart';
import '/../core/failure/failure.dart';
import '/../core/usecases/usecases.dart';
import '/../features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddSkateSpotUseCase implements UseCaseWithParams<void, AddSkateSpotParams>{
  final AddSkateSpotRepo repo;
  const AddSkateSpotUseCase({required this.repo});

  @override
  Future<Either<Failure, void>> call(params) async{
    return await repo.addSkateSpot(
        spotName: params.spotName,
        spotDescription: params.spotDescription,
        spotLat: params.spotLat,
        spotLang: params.spotLang,
        spotPhotos: params.spotPhotos,
        spotRanks: params.spotRanks,
        spotProperties: params.spotProperties,
        spotID: params.spotID,
        spotRiders: params.spotRiders,
        spotComments: params.spotComments);
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AddSkateSpotParams extends Equatable{
  final String spotName;
  final String spotDescription;
  final String spotLat;
  final String spotLang;
  final List<String> spotPhotos;
  final List<double> spotRanks;
  final List<String> spotProperties;
  final String spotID;
  final List<MyUser> spotRiders;
  final List<String> spotComments;
  const AddSkateSpotParams({
    required this.spotID,
    required this.spotComments,
    required this.spotDescription,
    required this.spotLang,
    required this.spotLat,
    required this.spotName,
    required this.spotPhotos,
    required this.spotProperties,
    required this.spotRanks,
    required this.spotRiders,
});

  @override
  List<Object> get props => [
    spotName,
    spotRiders,
    spotProperties,
    spotLat,
    spotLang,
    spotDescription
  ];

}