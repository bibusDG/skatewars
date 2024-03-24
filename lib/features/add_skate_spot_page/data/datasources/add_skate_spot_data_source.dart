import '../../../user_relations/domain/entities/my_user.dart';
import '/../core/constants/constants.dart';
import '/../features/add_skate_spot_page/domain/entities/skateSpot.dart';
import 'package:injectable/injectable.dart';

abstract class AddSkateSpotDataSource {
  const AddSkateSpotDataSource();

  Future<void> addSkateSpot({
    required String spotName,
    required String spotDescription,
    required String spotLat,
    required String spotLang,
    required List<String> spotPhotos,
    required List<double> spotRanks,
    required List<String> spotProperties,
    required String spotID,
    required List<MyUser> spotRiders,
    required List<String> spotComments,
  });
}

@Singleton(as: AddSkateSpotDataSource)
class AddSkateSpotDataImp implements AddSkateSpotDataSource {
  @override
  Future<void> addSkateSpot(
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
    final new_skateSpot = await FIREBASE_PATH.add(SkateSpot(
        spotName: spotName,
        spotDescription: spotDescription,
        spotLat: spotLat,
        spotLang: spotLang,
        spotPhotos: spotPhotos,
        spotRanks: spotRanks,
        spotProperties: spotProperties,
        spotID: spotID,
        spotRiders: spotRiders,
        spotComments: spotComments).toJson());
    final skateSpotID = new_skateSpot.id;
    await FIREBASE_PATH.doc(skateSpotID).update({'spotID': skateSpotID});
    // TODO: implement addSkateSpot
    // throw UnimplementedError();
  }
}
