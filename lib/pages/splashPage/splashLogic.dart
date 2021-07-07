import 'dart:async';
import 'package:testnewproject/pages/homePage/homeUI.dart';
import 'package:testnewproject/pages/introPage/introUI.dart';
import 'package:testnewproject/pages/verifyNumberPage/verifyNumberUI.dart';

import '../../main.dart';
import '../../providers/globalHeroProvider.dart' as globalHero;
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
    //do whatever you need when 1st start the app
    //then close the splash screen by pushing a home page

    globalHero.initializeApp().then((value) {
      print(value);
      //Done with pre-checking, close the splash screen and setup Homepage.
      switch (value) {
        case 'home':
          homeScreen = HomeUI();
          Navigator.pushNamedAndRemoveUntil(
              globalHero.navigatorKey.currentState.overlay.context,
              '/',
              (_) => false);
          break;
        case 'intro':
          homeScreen = IntroUI();
          Navigator.pushNamedAndRemoveUntil(
              globalHero.navigatorKey.currentState.overlay.context,
              '/',
              (_) => false);
          break;
        case 'verifynumber':
          homeScreen = VerifyNumberUI();
          Navigator.pushNamedAndRemoveUntil(
              globalHero.navigatorKey.currentState.overlay.context,
              '/',
              (_) => false);
          break;
      }
    });

    // Future.delayed(Duration(seconds: 4), () {
    //   //Replace HomeScreen with a new homescreen
    //   homeScreen = TestWidget();
    //   Navigator.pushNamedAndRemoveUntil(
    //       globalHero.navigatorKey.currentState.overlay.context,
    //       'intro',
    //       (_) => false);

    //   // //Pop to a specific page normally
    //   // Navigator.pushNamed(
    //   //     globalHero.navigatorKey.currentState.overlay.context, 'intro');

    //   // //Pop to Root, rm every other pages in stack
    //   // Navigator.pushNamedAndRemoveUntil(
    //   //     globalHero.navigatorKey.currentState.overlay.context,
    //   //     '/',
    //   //     (_) => false);
    // });
  }
}
