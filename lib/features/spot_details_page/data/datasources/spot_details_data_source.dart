import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';

import '../../../add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class SpotDetailsDatasource{
  const SpotDetailsDatasource();

  Stream<SkateSpot> getSpotDetails({
    required String spotID
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

}