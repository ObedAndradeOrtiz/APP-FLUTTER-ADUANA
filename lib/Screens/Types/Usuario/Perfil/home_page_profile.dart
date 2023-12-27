import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:app_universal/widget/group_tile.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/pose34.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Usuario: ${userbody["Nombres"]}" +
                      " " +
                      "${userbody["Apellidos"]}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '',
                  style: TextStyle(color: lightBlueColor, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Column(
                            children: [
                              Text(
                                'Tu Informacion QR:',
                                style: tittleTextStyle,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Center(
                                  child: QrImage(
                                data: "Usuario: ${userbody["Nombres"]}" +
                                    " " +
                                    "${userbody["Apellidos"]}",
                                size: 300,
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Mas detalles:',
                                style: tittleTextStyle,
                              ),
                              GroupTile(
                                  imageUrl: 'assets/images/ISOTIPO.png',
                                  name: 'Desarroladora de App:',
                                  text: 'Ágora Soluciones',
                                  time: '2022',
                                  unread: true)
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
