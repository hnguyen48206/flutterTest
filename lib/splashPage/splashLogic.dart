import 'dart:async';

class SplashLogic {
  int counter = 0;
  StreamController counterController = new StreamController<int>();
  Stream get counterStream => counterController.stream;

  void displayLoading() {
    counterController.sink.add(counter);
  }

  void dispose() {
    counterController.close();
  }
}
