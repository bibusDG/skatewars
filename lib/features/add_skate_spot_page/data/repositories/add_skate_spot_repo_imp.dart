import 'package:dartz/dartz.dart';
import '../../../user_relations/domain/entities/my_user.dart';
import '/../core/failure/failure.dart';
import '/../features/add_skate_spot_page/add_skate_spot_failures.dart';
import '/../features/add_skate_spot_page/data/datasources/add_skate_spot_data_source.dart';
import '/../features/add_skate_spot_page/domain/repositories/add_skate_spot_repo.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AddSkateSpotRepo)
class AddSkateSpotRepoImp implements AddSkateSpotRepo {
  final AddSkateSpotDataSource addSkateSpotDataSource;
  const AddSkateSpotRepoImp({required this.addSkateSpotDataSource});

  @override
  Future<Either<Failure, void>> addSkateSpot(
      {required String spotName,
      required String spotDescription,
      required String spotLat,
      required String spotLang,
      required List<String> spotPhotos,
      required List<double> spotRanks,
      required List<String> spotProperties,
      required String spotID,
      required List<MyUser> spotRiders,
      required List<String> spotComments}) async{
    try{
      final result = addSkateSpotDataSource.addSkateSpot(
          spotName: spotName, 
          spotDescription: spotDescription, 
          spotLat: spotLat, 
          spotLang: spotLang, 
          spotPhotos: spotPhotos, 
          spotRanks: spotRanks, 
          spotProperties: spotProperties, 
          spotID: spotID, 
          spotRiders: spotRiders, 
          spotComments: spotComments);
      return Right(result);
    }catch(error){
      print('Unable to add new skate spot');
      return (const Left(AddSkateSpotFailure(failureMessage: 'Unable to add new skate spot')));
    }
    // TODO: implement addSkateSpot
    throw UnimplementedError();
  }
}
