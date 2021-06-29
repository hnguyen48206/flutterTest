import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  @override
  void initState() {
    context.showLoaderOverlay(widget: SplashUI());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoaderOverlay(
        useDefaultLoading: true,
        overlayOpacity: 0.8,
        child: Image.asset(
          "assets/imgs/home.JPEG",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
