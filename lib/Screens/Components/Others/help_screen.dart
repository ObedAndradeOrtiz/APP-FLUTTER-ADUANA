
// ignore_for_file: unused_local_variable

import 'package:app_universal/global/app_theme.dart';
import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

bool enviando = false;
String text = "";
String _img = "";

class HelpScreen extends StatefulWidget {
  HelpScreen(String img) {
    _img = img;
  }
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 12,
                title: const Text('¿Desea volver?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      setState(() {
                        _img = "";
                      });
                    },
                    child: const Text('Si'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: enviando == false
            ? Container(
                color: AppTheme.nearlyWhite,
                child: SafeArea(
                  top: false,
                  child: Scaffold(
                    backgroundColor: primaryColor,
                    body: Column(
                      children: <Widget>[

                        SizedBox(height: MediaQuery.of(context).size.height/6,),
                        Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromARGB(255, 79, 151, 199)
                                  .withOpacity(0.6),
                              offset: const Offset(2.0, 4.0),
                              blurRadius: 40),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        child: Image.asset(
                          logoSecundario,
                        
                        ),
                      )),
                        // Container(
                        //   padding: EdgeInsets.only(
                        //       top: MediaQuery.of(context).size.height / 24,
                        //       left: 16,
                        //       right: 16),
                        //   child: _img != ""
                        //       ? Image.asset(
                        //           _img,
                        //           width: 250,
                        //           height: 250,
                        //         )
                        //       : Center(),
                        // ),
                        Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '¿En que podemos ayudarte?',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 0, top: 0, bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(38.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 4, bottom: 4),
                                child: TextField(
                                  onChanged: (String txtX) {
                                    setState(() {
                                      text = txtX;
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Mensaje... ',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              width: 140,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(80.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      offset: const Offset(4, 4),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                  color: Colors.transparent,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(() {
                                        enviando = true;
                                        if (_img ==
                                            "assets/images/imgAgoraApp.png") {
                                          enviarMensaje(text);
                                        } else {
                                          enviarMensajeAltebol(text);
                                        }
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Color.fromARGB(255, 38, 47, 119),
                                            Color.fromARGB(200, 25, 150, 211)
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            minWidth: 88.0,
                                            minHeight:
                                                36.0), // min sizes for Material buttons
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Enviar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: primaryColor,
                body: SafeArea(
                    child: Center(
                  child: Container(
                      decoration: BoxDecoration(color: primaryColor),
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
                                  "Desarrollado por Ágora",
                                  style: TextStyle(
                                      color:primaryColor,
                                      fontWeight: FontWeight.w700),
                                )), // Your footer widget
                          )),
                        ],
                      )),
                ))));
  }

  void enviarMensaje(String descripcion) async {
    String mensaje = "NOTIFICACION:|" +
        "${userbody['RazonSocial']}" +
        descripcion +
        "|AGENCIA: IMEX GROUP ";
    var response = await http.get(
      Uri.parse("$url/mensajesSoporte?message=" + mensaje),
      headers: {"Authorization":"Bearer "+tokenApi.toString()}
    );

    setState(() {
      enviando = false;
    });
  }

  void enviarMensajeAltebol(String descripcion) async {
    String mensaje = "NOTIFICACION:|" +
        "USUARIO: ${userbody['Nombres']}|" +
        descripcion +
        "|AGENCIA: R&S ";
    var response = await http.get(
      Uri.parse("$url/mensajesSoporteAltel?message=" + mensaje),
      headers: {"Authorization":"Bearer "+tokenApi.toString()}
    );

    setState(() {
      enviando = false;
    });
  }
}
