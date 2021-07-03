import 'dart:async';
import '../main.dart';
import '../providers/globalHeroProvider.dart' as globalHero;
import 'package:flutter/material.dart';

class SplashLogic {
  StreamController splashController = new StreamController<String>();
  Stream get splashStream => splashController.stream;
  String wallpaper = 'assets/imgs/home.JPEG';

  void displayLoading() {
    globalHero.isLoggedIn = true;
    wallpaper = 'assets/imgs/intro.JPEG';
    splashController.sink.add(wallpaper);
  }

  void dispose() {
    splashController.close();
  }

  void startLogic() {
    //do whatever you need when 1st start the widget                    ;
    Future.delayed(Duration(seconds: 4), () {
      homeScreen = TestWidget();
      Navigator.pushNamed(navigatorKey.currentState.overlay.context, 'intro');
    });
  }
}
