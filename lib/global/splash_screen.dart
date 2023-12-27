
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

dynamic _screen;

class SplashScreenInit extends StatefulWidget {
  SplashScreenInit(Widget screen, {Key? key}) : super(key: key) {
    _screen = screen;
  }

  @override
  State<SplashScreenInit> createState() => _SplashScreenInit();
}

class _SplashScreenInit extends State<SplashScreenInit> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 2000),
        () => Navigator.of(context).push(PageRouteBuilder(
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secanimation,
                Widget child) {
              return ScaleTransition(
                  scale: animation, alignment: Alignment.center, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secanimation) {
              return _screen;
            })));

    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
      print(identifier);
      myIDuserAndroid = identifier;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: Center(
          child: Container(
              decoration: BoxDecoration(color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Center(
                    child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Image.asset(
                          logogeneral,
                          scale: 1,
                        )),
                  ),
                  CircularProgressIndicator(),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: 25,
                        child: Text(
                          "Power by Ágora Soluciones",
                          style: TextStyle(
                              color: white, fontWeight: FontWeight.w700),
                        )), // Your footer widget
                  )),
                ],
              )),
        )));
  }
}
