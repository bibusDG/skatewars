import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:skatewars/core/constants/constants.dart';

import '../../../../core/custom_widgets/custom_bottom_app_bar.dart';

class StartPage extends HookWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final _userLoggedIn = USER_LOGGED_IN;
    final _user = LOGGED_USER;

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: AppBar(
        actions: [
          _userLoggedIn? CircleAvatar(child: Text(_user.userName[0]),) : SizedBox(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(onPressed: (){
            context.pushNamed('add_skate_spot_page');
                      }, color: Colors.black,child: const Text('Add spot'),),
            CupertinoButton(onPressed: (){
              context.pushNamed('show_skate_spots_page');
            }, color: Colors.black,child: const Text('Show spots'),),
            CupertinoButton(onPressed: (){
              context.pushNamed('login_page');
            }, color: Colors.black,child: const Text('Google login page'),),
          ],
        ),
      ),
    );
  }
}




