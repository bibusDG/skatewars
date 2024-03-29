part of 'user_auth_cubit.dart';

@freezed
class UserAuthState with _$UserAuthState {
  const factory UserAuthState.initial() = _Initial;

  const factory UserAuthState.loginInitialPage() = _LoginInitialPage;
  const factory UserAuthState.loginPageError({required String message}) = _LoginPageError;
  const factory UserAuthState.loginPageLoading() = _LoginPageLoading;
  const factory UserAuthState.loginSuccess({required String message}) = _LoginSuccess;
  const factory UserAuthState.loginFailed({required String message}) = _LoginFailed;
  const factory UserAuthState.loginInProgress() = _LoginInProgress;

}
