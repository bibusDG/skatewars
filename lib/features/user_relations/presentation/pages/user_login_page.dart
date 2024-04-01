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
  final String userLoggedIn;
  const UserLoginPage({super.key, required this.userLoggedIn});

  @override
  Widget build(BuildContext context) {

    final _userEmail = useTextEditingController();
    final _userPassword = useTextEditingController();

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
        loginSuccess: (message, uid) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : uid});
          }
        },
        loggedOutSuccess: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            context.goNamed('show_skate_spots_page', pathParameters: {'uid' : 'null'});
          }
        },
        loginPageError: (message) async{
          await Future.delayed(const Duration(seconds: 3));
          if(context.mounted){
            _authCubit.loginInitialPage(userLoggedIn: USER_LOGGED_IN.toString());
          }
        }
      );
    });

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(uid: 'dd',),
      appBar: AppBar(title: Text('USER LOGIN PAGE'),
      ),
      body: _authState.whenOrNull(
        userLoggedInInitialPage: () => Center(child: CupertinoButton(onPressed: (){
          _authCubit.logOutUser();
        }, child: Text('LogOut'),),),
        userLoggedOutInitialPage:() => Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                controller: _userEmail,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color: Colors.orange), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)),
                  // errorText: errorText,
                  hintText: 'E-mail',
                  // icon: icon,
                ),

              ),
            ),
            const SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextFormField(
                controller: _userPassword,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 1, color: Colors.orange), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 4, color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)),
                  // errorText: errorText,
                  hintText: 'Password',
                  // icon: icon,
                ),

              ),
            ),
            const SizedBox(height: 20.0,),
            CupertinoButton(onPressed: (){
              _authCubit.loginWithEmail(userEmail: _userEmail.text, userPassword: _userPassword.text);
            }, color: Colors.black, child: const Text('Login'),),
            const SizedBox(height: 70,),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80),
              child: CupertinoButton(onPressed: (){
                _authCubit.loginWithGoogle();
              },color: Colors.black, child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(child: Image.network(
                      'http://pngimg.com/uploads/google/google_PNG19635.png',
                      fit:BoxFit.cover
                  ),),
                  const Text('Login with Google'),
                ],
              ),),
            ),
          ],
        ),),
        loginSuccess: (message, uid) => Center(child: Text(message),),
        loginInProgress: () => Center(child: CircularProgressIndicator(),),
        loginFailed: (message) => Center(child: Text(message),),
        loginPageLoading: () => Center(child: CircularProgressIndicator(),),
        loggedOutSuccess: (message) => Center(child: Text(message),),
        loginPageError: (message) => Center(child: Text(message)),
      ),
    );
  }
}
