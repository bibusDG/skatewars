import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class StartPage extends HookWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoButton(child: Text('Start'), onPressed: (){
          context.pushNamed('add_skate_spot_page');
        }, color: Colors.black,),
      ),
    );
  }
}
