part of 'user_auth_cubit.dart';

@freezed
class UserAuthState with _$UserAuthState {
  const factory UserAuthState.initial() = _Initial;


  const factory UserAuthState.userRegisterInitialPage() = _UserRegisterInitialPage;
  const factory UserAuthState.registeringInProgress() = _RegisteringInProgress;
  const factory UserAuthState.registerFailure({required String message}) = _RegisterFailure;
  const factory UserAuthState.registerSuccess({required String message}) = _RegisterSuccess;

  const factory UserAuthState.userLoggedInInitialPage({required MyUser user, required List<SkateSpot> favSpots}) = _UserLoggedInInitialPage;
  const factory UserAuthState.userLoggedOutInitialPage() = _UserLoggedOutInitialPage;
  const factory UserAuthState.loginSuccess({required String message, required String uid}) = _LoginSuccess;
  const factory UserAuthState.loginFailed({required String message}) = _LoginFailed;

  const factory UserAuthState.loggedOutSuccess({required String message}) = _UserLoggedOutSuccess;
  const factory UserAuthState.loggedOutFailure({required String message}) = _UserLoggedOutFailure;

  const factory UserAuthState.loginPageError({required String message}) = _LoginPageError;
  const factory UserAuthState.loginPageLoading() = _LoginPageLoading;
  const factory UserAuthState.loginInProgress() = _LoginInProgress;

}
