
import '../../../user_relations/domain/entities/my_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'skateSpot.freezed.dart';
part 'skateSpot.g.dart';

@freezed
class SkateSpot with _$SkateSpot{
  const factory SkateSpot({
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

}) = _SkateSpot;
  factory SkateSpot.fromJson(Map<String, dynamic>? json) => _$SkateSpotFromJson(json!);
}