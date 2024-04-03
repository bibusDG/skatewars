import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';

import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class SpotDetailsDatasource{
  const SpotDetailsDatasource();

  Stream<SkateSpot> getSpotDetails({
    required String spotID
});

  Future<void> addUserToSpot({
    required String userID,
    required String spotID,
});

  Future<void> removeUserFromSpot({
    required String userID,
    required String spotID,
});

}
@Singleton(as:SpotDetailsDatasource)
class SpotDetailsDataSourceImp implements SpotDetailsDatasource{
  @override
  Stream<SkateSpot> getSpotDetails({required String spotID}) async*{
    yield* FIREBASE_PATH.doc(spotID).snapshots().map((snapshot) => SkateSpot.fromJson(snapshot.data()));
    // TODO: implement getSpotDetails
    // throw UnimplementedError();
  }

  @override
  Future<void> addUserToSpot({required String userID, required String spotID}) async{
    await FIREBASE_PATH.doc(spotID).update({'spotRiders': FieldValue.arrayUnion([userID])});
    // TODO: implement addUserToSpot
    // throw UnimplementedError();
  }

  @override
  Future<void> removeUserFromSpot({required String userID, required String spotID}) async{
    await FIREBASE_PATH.doc(spotID).update({'spotRiders': FieldValue.arrayRemove([userID]),});
    // TODO: implement removeUserFromSpot
    // throw UnimplementedError();
  }

}