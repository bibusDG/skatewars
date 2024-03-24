import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_user.freezed.dart';
part 'my_user.g.dart';
@freezed
class MyUser with _$MyUser{
  const factory MyUser({
    required String userEmail,
    required String userPassword,
    required String userName,
    required String userSureName,
    required String userAvatar,
    required String userMobileToken,
    required String userID,
}) = _MyUser;
  factory MyUser.fromJson(Map<String, dynamic>? json) => _$MyUserFromJson(json!);
}