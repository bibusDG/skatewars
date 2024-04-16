import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

    changePage(context: context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          _userLoggedIn? CircleAvatar(child: Text(_user.userName[0]),) : const SizedBox(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              effects: const [
                FadeEffect(),
              ],
                child: const Text('SKATE WARS', style: TextStyle(fontSize: 70, fontWeight: FontWeight.w100),).animate().fadeIn(duration: 1.seconds)),
            const Text('find skate spot and ride...', style: TextStyle(fontSize: 25),),
          ],
        ),
      ),
    );
  }

  Future<void> changePage({required BuildContext context}) async{
    await Future.delayed(Duration(seconds: 5));
    if(context.mounted){
      context.goNamed('show_skate_spots_page', pathParameters: {'uid': 'null'});
    }
  }

}




