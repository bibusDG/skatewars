import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_comment.freezed.dart';
part 'user_comment.g.dart';

@freezed
class UserComment with _$UserComment{
  const factory UserComment({
    required String userName,
    required String comment,
    required String creationDate,
    required double userRate,

}) = _UserComment;
  factory UserComment.fromJson(Map<String, dynamic>? json) => _$UserCommentFromJson(json!);
}