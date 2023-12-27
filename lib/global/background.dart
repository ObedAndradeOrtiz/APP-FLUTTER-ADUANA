// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  // ignore: unused_field
  bool _escribiendo = false;
  Background(
    bool escribiendo, {
    Key? key,
    required this.child,
  }) : super(key: key) {
    _escribiendo = escribiendo;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top2v2.png", width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top1.png", width: size.width),
          ),
          Positioned(
            top: size.height / 6,
            right: size.width / 2.2,
            child:
                Image.asset("assets/images/logoh.png", width: size.width * 0.5),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/inicioabajo1.png",
                width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom2.png", width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
