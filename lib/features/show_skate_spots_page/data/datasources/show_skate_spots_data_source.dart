import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class ShowSkateSpotsDataSource{
  const ShowSkateSpotsDataSource();

  Stream<List<SkateSpot>> streamSkateSpots({
    required String distance,
});

  Future<void> addSpotToUserFavorites({
    required String spotID,
    required String userID,
  });

  Future<void> removeSpotFromUserFavorites({
    required String spotID,
    required String userID,
  });

  Future<SkateSpot> getSpotByID({
    required String spotID,
  });

}
@Singleton(as: ShowSkateSpotsDataSource)
class ShowSkateSpotDataSourceImp implements ShowSkateSpotsDataSource{
  @override
  Stream<List<SkateSpot>> streamSkateSpots({required String distance}) async*{
    yield*  FIREBASE_PATH.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => SkateSpot.fromJson(doc.data())).toList());
    // TODO: implement streamSkateSpots
    // throw UnimplementedError();
  }

  @override
  Future<void> addSpotToUserFavorites({required String spotID, required String userID}) async{
    await FIREBASE_USER_PATH.doc(userID).update({'favouriteSpots': FieldValue.arrayUnion([spotID])});
    // TODO: implement addSpotToUserFavorites
    // throw UnimplementedError();
  }

  @override
  Future<SkateSpot> getSpotByID({required String spotID}) async{
    final result = await FIREBASE_PATH.doc(spotID).get();
    final spot = SkateSpot.fromJson(result.data());
    return spot;
    // TODO: implement getSpotByID
    throw UnimplementedError();
  }

  @override
  Future<void> removeSpotFromUserFavorites({required String spotID, required String userID}) async{
    await FIREBASE_USER_PATH.doc(userID).update({'favouriteSpots': FieldValue.arrayRemove([spotID])});
    // TODO: implement removeSpotFromUserFavorites
    // throw UnimplementedError();
  }
}