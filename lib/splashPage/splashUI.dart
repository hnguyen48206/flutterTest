import 'package:flutter/material.dart';
import 'splashLogic.dart';
import '../providers/globalHeroProvider.dart' as globalHero;

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
    print(globalHero.isLoggedIn);
    widget.splashStream.startLogic();
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
        stream: widget.splashStream.splashStream,
        builder: (context, snapshot) {
          print(globalHero.isLoggedIn);
          return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.splashStream.wallpaper),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                ),
              ),
              // use any child here
              child: Center(child: CircularProgressIndicator()));
        });
  }
}
