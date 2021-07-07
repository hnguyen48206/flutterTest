library global_heroes_provider.globals;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final LocalStorage localStorage = new LocalStorage('masterLocalStorage');

bool isLoggedIn = false;
String verifiredPhoneNumber = "";

Future<String> initializeApp() async {
  await localStorage.ready;
  setupChatHistoryStorage();
  return setupHomePageByVerifiedNumber();
}

String setupHomePageByVerifiedNumber() {
  verifiredPhoneNumber = localStorage.getItem('verifiredPhoneNumber');
  print(verifiredPhoneNumber);
  if (verifiredPhoneNumber == null) {
    //No verified number, check if user has read the intro
    if (localStorage.getItem('hasReadIntroPage') == null) {
      return 'intro';
    } else if (localStorage.getItem('hasReadIntroPage')) {
      //User has never verified a number, but already agree to the Intro
      return 'verifynumber';
    } else {
      //User has never verified a number or agreed to the Intro
      return 'intro';
    }
  } else {
    //phoneNumber is already available, good to go next
    return 'home';
  }
}

Future<void> setupChatHistoryStorage() {
  if (localStorage.getItem('113_ChatHistory') == null) {
    localStorage.setItem('113_ChatHistory', json.encode([]));
  }
  if (localStorage.getItem('114_ChatHistory') == null) {
    localStorage.setItem('114_ChatHistory', json.encode([]));
  }
  if (localStorage.getItem('115_ChatHistory') == null) {
    localStorage.setItem('115_ChatHistory', json.encode([]));
  }
}
