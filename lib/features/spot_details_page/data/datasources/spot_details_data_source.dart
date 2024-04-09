import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/spot_details_page/domain/entities/user_comment.dart';

import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class SpotDetailsDatasource {
  const SpotDetailsDatasource();

  Stream<SkateSpot> getSpotDetails({required String spotID});

  Future<void> addUserToSpot({
    required String userID,
    required String spotID,
  });

  Future<void> removeUserFromSpot({
    required String userID,
    required String spotID,
  });

  Future<void> rateSpot({
    required String userName,
    required String comment,
    required String creationDate,
    required String spotID,
    required double userRate,
  });
}

@Singleton(as: SpotDetailsDatasource)
class SpotDetailsDataSourceImp implements SpotDetailsDatasource {
  @override
  Stream<SkateSpot> getSpotDetails({required String spotID}) async* {
    yield* FIREBASE_PATH.doc(spotID).snapshots().map((snapshot) => SkateSpot.fromJson(snapshot.data()));
    // TODO: implement getSpotDetails
    // throw UnimplementedError();
  }

  @override
  Future<void> addUserToSpot({required String userID, required String spotID}) async {
    await FIREBASE_PATH.doc(spotID).update({
      'spotRiders': FieldValue.arrayUnion([userID])
    });
    // TODO: implement addUserToSpot
    // throw UnimplementedError();
  }

  @override
  Future<void> removeUserFromSpot({required String userID, required String spotID}) async {
    await FIREBASE_PATH.doc(spotID).update({
      'spotRiders': FieldValue.arrayRemove([userID]),
    });
    // TODO: implement removeUserFromSpot
    // throw UnimplementedError();
  }

  @override
  Future<void> rateSpot(
      {required String userName,
        required String comment,
        required String creationDate,
        required String spotID,
        required double userRate}) async{
    final userComment = await FIREBASE_COMMENTS_PATH.add(
        UserComment(
            userName: userName,
            comment: comment,
            creationDate: creationDate,
            userRate: userRate).toJson());
    final commentID = userComment.id;
    await FIREBASE_PATH.doc(spotID).update({
    'spotComments': FieldValue.arrayUnion([commentID]),
    });
    await FIREBASE_PATH.doc(spotID).update({
      'spotRanks': FieldValue.arrayUnion([userRate]),
    });
    // TODO: implement rateSpot
    // throw UnimplementedError();
  }
}
