// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skateSpot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkateSpotImpl _$$SkateSpotImplFromJson(Map<String, dynamic> json) =>
    _$SkateSpotImpl(
      spotName: json['spotName'] as String,
      spotDescription: json['spotDescription'] as String,
      spotLat: json['spotLat'] as String,
      spotLang: json['spotLang'] as String,
      spotPhotos: (json['spotPhotos'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spotRanks: (json['spotRanks'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      spotProperties: (json['spotProperties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spotID: json['spotID'] as String,
      spotRiders: (json['spotRiders'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spotComments: (json['spotComments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SkateSpotImplToJson(_$SkateSpotImpl instance) =>
    <String, dynamic>{
      'spotName': instance.spotName,
      'spotDescription': instance.spotDescription,
      'spotLat': instance.spotLat,
      'spotLang': instance.spotLang,
      'spotPhotos': instance.spotPhotos,
      'spotRanks': instance.spotRanks,
      'spotProperties': instance.spotProperties,
      'spotID': instance.spotID,
      'spotRiders': instance.spotRiders,
      'spotComments': instance.spotComments,
    };
