
// ignore_for_file: unnecessary_import

import 'package:animate_do/animate_do.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loging(context) {
  return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Center(
        child: Container(
            decoration: BoxDecoration(color: white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 17,
                // ),
                Center(
                  child: FadeIn(
                    // ignore: sort_child_properties_last
                    child: Column(children: [


                      SizedBox(height: MediaQuery.of(context).size.height/10,),
                      FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Image.asset(
                            logogeneral,
                            scale: 0.5,
                          )),

                      Image.asset(
                        "assets/icons/loading3.gif",
                        scale: 1,
                        width: 300,
                      )
                      // const LinearProgressIndicator(
                      //   color: Color.fromARGB(255, 23, 65, 139),
                      //   minHeight: 7,
                      // )
                    ]),
                    duration: const Duration(seconds: 3),
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 25,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/iconoisotipo.png",
                                    scale: 0.4,
                                  ),
                                  const Text(
                                    "Powered by Ágora",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ])) // Your footer widget
                        )),
              ],
            )),
      )));
}
