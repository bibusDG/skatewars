import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/user_relations/domain/usecases/user_logged_in_usecase.dart';

import '../../domain/usecases/log_out_user_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/register_new_user_usecase.dart';

part 'user_auth_state.dart';
part 'user_auth_cubit.freezed.dart';

@injectable
class UserAuthCubit extends Cubit<UserAuthState> {
  final UserLoggedInUseCase userLoggedInUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogOutUserUseCase logOutUserUseCase;
  final RegisterNewUserUseCase registerNewUseUseCase;
  UserAuthCubit({
    required this.userLoggedInUseCase,
    required this.registerNewUseUseCase,
    required this.loginWithGoogleUseCase,
    required this.logOutUserUseCase}) : super(const UserAuthState.initial());

  StreamSubscription<User?>? _streamSubscription;

  Future<void> loginInitialPage() async{
    emit(const UserAuthState.loginInitialPage());
  }

  Future<void> logOutUser() async{
    final result = await logOutUserUseCase();
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Unable to log-out'));
    }, (success){
      emit(const UserAuthState.loginInitialPage());
    });
  }

  Future<void> loginWithGoogle() async{
    emit(const UserAuthState.loginInProgress());
    final result = await loginWithGoogleUseCase();
    result.fold((failure){
    emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (success) async{
      final result = await userLoggedInUseCase();
      result.fold((failure){}, (success){
        _streamSubscription = success.listen((event) {
          if(event == null){
            USER_LOGGED_IN = false;
            emit(const UserAuthState.loginSuccess(message: 'dd'));
          }else{
            USER_LOGGED_IN = true;
            emit(const UserAuthState.loginSuccess(message: 'dd'));
          }
        });
      });
      // emit(const UserAuthState.loginInProgress());
      // final result = await registerNewUseUseCase(RegisterNewUserParams(
      //     userEmail: success.user!.email!,
      //     userPassword: '',
      //     userName: success.user!.displayName!,
      //     userSureName: '',
      //     userAvatar: success.user!.photoURL!,
      //     userMobileToken: '',
      //     userID: '',
      //     favouriteSpots: const [],
      //     skatePoints: 0,
      //     skateWarsWon: 0,
      //     skateWarsLost: 0));
      // result.fold((failure){
      // emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
      // }, (success){
      // emit(const UserAuthState.loginSuccess(message: 'Success'));
      // });

    });
  }

  @override
  Future<void> close() async{
    _streamSubscription?.cancel();
    super.close();
  }

}
