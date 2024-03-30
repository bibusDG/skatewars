import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/core/custom_widgets/custom_bottom_app_bar.dart';
import 'package:skatewars/features/user_relations/domain/entities/my_user.dart';
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart';

class UserLoginPage extends HookWidget {
  final bool userLoggedIn;
  const UserLoginPage({super.key, required this.userLoggedIn});

  @override
  Widget build(BuildContext context) {


    final _authCubit = useBloc<UserAuthCubit>();
    final _authState = useBlocBuilder(_authCubit);

    useEffect((){
      _authCubit.loginInitialPage(userLoggedIn: userLoggedIn);
      return null;
    },
      [_authCubit],
    );

    useBlocListener<UserAuthCubit, UserAuthState>(_authCubit, (bloc, current, context) {
      current.whenOrNull(
        loginSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page');
          }
        },
        loggedOutSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page');
          }
        }
      );
    });

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: AppBar(title: Text('USER LOGIN PAGE'),
      ),
      body: _authState.whenOrNull(
        userLoggedInInitialPage: () => Center(child: CupertinoButton(onPressed: (){
          _authCubit.logOutUser();
        }, child: Text('LogOut'),),),
        userLoggedOutInitialPage:() => Center(child: CupertinoButton(onPressed: (){
          _authCubit.loginWithGoogle();
        }, child: Text('Login with google'),),),
        loginSuccess: (message) => Center(child: Text(message),),
        loginInProgress: () => Center(child: CircularProgressIndicator(),),
        loginFailed: (message) => Center(child: Text(message),),
        loginPageLoading: () => Center(child: CircularProgressIndicator(),),
        loggedOutSuccess: (message) => Center(child: Text(message),),
      ),
    );
  }
}
