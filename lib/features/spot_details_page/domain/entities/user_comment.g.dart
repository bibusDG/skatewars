// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCommentImpl _$$UserCommentImplFromJson(Map<String, dynamic> json) =>
    _$UserCommentImpl(
      userName: json['userName'] as String,
      comment: json['comment'] as String,
      creationDate: json['creationDate'] as String,
      userRate: (json['userRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$UserCommentImplToJson(_$UserCommentImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'comment': instance.comment,
      'creationDate': instance.creationDate,
      'userRate': instance.userRate,
    };
