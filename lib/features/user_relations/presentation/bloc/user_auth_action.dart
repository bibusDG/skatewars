part of 'user_auth_cubit.dart';

@freezed
class UserAuthAction with _$UserAuthAction {
  const factory UserAuthAction.initial() = _ActionInitial;

  const factory UserAuthAction.loginActionMessage({required String message}) = _LoginActionMessage;
  const factory UserAuthAction.signInActionMessage({required String message}) = _SignInActionMessage;
}
