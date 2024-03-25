import 'package:geolocator/geolocator.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/add_skate_spot_page/domain/entities/skateSpot.dart';

abstract class ShowSkateSpotsDataSource{
  const ShowSkateSpotsDataSource();

  Stream<List<SkateSpot>> streamSkateSpots({
    required String distance,
    required Position userPosition,
});

}

class ShowSkateSpotDataSourceImp implements ShowSkateSpotsDataSource{
  @override
  Stream<List<SkateSpot>> streamSkateSpots({required String distance, required Position userPosition}) async*{
    yield*  FIREBASE_PATH.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => SkateSpot.fromJson(doc.data())).toList());
    // TODO: implement streamSkateSpots
    // throw UnimplementedError();
  }
}