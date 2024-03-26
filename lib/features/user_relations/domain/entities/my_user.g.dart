// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyUserImpl _$$MyUserImplFromJson(Map<String, dynamic> json) => _$MyUserImpl(
      userEmail: json['userEmail'] as String,
      userPassword: json['userPassword'] as String,
      userName: json['userName'] as String,
      userSureName: json['userSureName'] as String,
      userAvatar: json['userAvatar'] as String,
      userMobileToken: json['userMobileToken'] as String,
      userID: json['userID'] as String,
      favouriteSpots: (json['favouriteSpots'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      skatePoints: json['skatePoints'] as int,
      skateWarsWon: json['skateWarsWon'] as int,
      skateWarsLost: json['skateWarsLost'] as int,
    );

Map<String, dynamic> _$$MyUserImplToJson(_$MyUserImpl instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
      'userName': instance.userName,
      'userSureName': instance.userSureName,
      'userAvatar': instance.userAvatar,
      'userMobileToken': instance.userMobileToken,
      'userID': instance.userID,
      'favouriteSpots': instance.favouriteSpots,
      'skatePoints': instance.skatePoints,
      'skateWarsWon': instance.skateWarsWon,
      'skateWarsLost': instance.skateWarsLost,
    };
