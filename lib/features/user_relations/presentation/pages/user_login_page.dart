import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/user_relations/presentation/bloc/user_auth_cubit.dart';

class UserLoginPage extends HookWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final _authCubit = useBloc<UserAuthCubit>();
    final _authState = useBlocBuilder(_authCubit);

    useEffect((){
      _authCubit.loginInitialPage();
      return null;
    },
      [_authCubit],
    );

    useBlocListener<UserAuthCubit, UserAuthState>(_authCubit, (bloc, current, context) {
      current.whenOrNull(
        // loginSuccess: (message) async{
        //   await Future.delayed(const Duration(seconds: 3));
        //   if(context.mounted){
        //     context.goNamed('start_page');
        //   }
        // }
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('USER LOGIN PAGE'),
        actions: [
          USER_LOGGED_IN == true? CircleAvatar(): SizedBox(),
        ],
      ),
      body: _authState.whenOrNull(
        loginInitialPage:() => Center(child: CupertinoButton(onPressed: (){
          _authCubit.loginWithGoogle();
        }, child: Text('Login with google'),),),
        loginSuccess: (message) => Center(child: Column(
          children: [
            Text(message),
            CupertinoButton(child: Text('Sign out'), onPressed: (){
              _authCubit.logOutUser();
            }),
          ],
        ),),
        loginInProgress: () => Center(child: CircularProgressIndicator(),),
        loginFailed: (message) => Center(child: Text(message),),
        loginPageLoading: () => Center(child: CircularProgressIndicator(),)
      ),
    );
  }
}
