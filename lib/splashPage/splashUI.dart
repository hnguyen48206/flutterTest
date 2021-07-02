import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'splashLogic.dart';

// ignore: must_be_immutable
class SplashUI extends StatefulWidget {
  SplashLogic splashStream = new SplashLogic();

  SplashUI({Key key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.splashStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.splashStream.counterStream,
        builder: (context, snapshot) {
          Future.delayed(Duration(seconds: 1), () {
            widget.splashStream.displayLoading();
            context.showLoaderOverlay();
          });
          return LoaderOverlay(
              useDefaultLoading: true,
              overlayOpacity: 0.8,
              child: Image.asset(
                "assets/imgs/home.JPEG",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ));
        });
  }
}
