import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skatewars/core/constants/constants.dart';

import '../../domain/entities/my_user.dart';
import '../../domain/usecases/log_out_user_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/register_new_user_usecase.dart';
import '../../domain/usecases/set_user_account_usecase.dart';

part 'user_auth_state.dart';
part 'user_auth_cubit.freezed.dart';

@injectable
class UserAuthCubit extends Cubit<UserAuthState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogOutUserUseCase logOutUserUseCase;
  final RegisterNewUserUseCase registerNewUseUseCase;
  final SetUserAccountUseCase setUserAccountUseCase;
  UserAuthCubit({
    required this.setUserAccountUseCase,
    required this.registerNewUseUseCase,
    required this.loginWithGoogleUseCase,
    required this.logOutUserUseCase}) : super(const UserAuthState.initial());

  Future<void> loginInitialPage({required bool userLoggedIn}) async{
    if(!userLoggedIn){
      emit(const UserAuthState.userLoggedOutInitialPage());
    }else{
      emit(const UserAuthState.userLoggedInInitialPage());
    }
  }

  Future<void> logOutUser() async{
    final result = await logOutUserUseCase();
    result.fold((failure){
      emit(const UserAuthState.loginPageError(message: 'Unable to log-out'));
    }, (success){
      USER_LOGGED_IN = false;
      LOGGED_USER = MyUser.empty();
      emit(const UserAuthState.loggedOutSuccess(message: 'LogOut successful'));
    });
  }

  Future<void> loginWithGoogle() async{
    emit(const UserAuthState.loginInProgress());
    ///login with google account
    final result = await loginWithGoogleUseCase();
    result.fold((failure){
    emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
    }, (success) async{
      ///if login success set user to data from userID firebase
      final result = await setUserAccountUseCase(SetUserAccountParams(userEmail: success.user!.email!));
      USER_LOGGED_IN = true;
      result.fold((failure){
        emit(const UserAuthState.loginPageError(message: 'Upps... something went wrong'));
      }, (success) async{
        emit(const UserAuthState.loginSuccess(message: 'Success'));
      });
    });
  }

}
