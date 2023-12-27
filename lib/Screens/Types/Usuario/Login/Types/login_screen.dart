// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/dashboard_main.dart';
import 'package:app_universal/global/theme.dart';
import 'package:app_universal/widget/widget_loging.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../../../../../global/constants.dart';

dynamic jsonBody;
var regVerficar;
final Map<String, String> FormValues = {
  'email': '',
  'password': '',
  'role': ''
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum SingingCharacter { Cliente, Interno }

class _LoginScreenState extends State<LoginScreen> {
  bool isload = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Desea salir de la aplicacion?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      exit(0);
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
        child: isload == false
            ? Scaffold(
                backgroundColor: white,
                body: SafeArea(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // child: Container(child: Column(children: [],),),
                      child: Container(
                          child: Column(children: [
                        SizedBox(height: size.height / 7),
                        SizedBox(
                          height: size.height / 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                logogeneral,
                                scale: 1,
                              )
                            ],
                          ),
                        ),

                        // // Positioned(
                        // //   child: Image.asset(logogeneral,
                        // //       width: size.width * 0.7),
                        // // ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Universal (Socio Comercial)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 29, 32, 226)),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.phone_android,
                                  color: primaryColor,
                                ))
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Iniciar Sesion",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: white,
                                fontSize: 25),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            style: TextStyle(color: primaryColor),
                            autofocus: false,
                            onTap: () {
                              setState(() {
                                escribiendoLogin = true;
                              });
                            },
                            onChanged: (value) {
                              FormValues['email'] = value;
                            },
                            decoration: InputDecoration(
                                labelText: "Nombre de usuario",
                                fillColor: white,
                                labelStyle: TextStyle(color: blueColor),
                                hintStyle: TextStyle(color: blueColor)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: TextFormField(
                            style: TextStyle(color: primaryColor),
                            autofocus: false,
                            onChanged: (value) {
                              FormValues['password'] = value;
                            },
                            decoration: InputDecoration(
                                labelText: "Contrasena",
                                labelStyle: TextStyle(color: blueColor)),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                          child: RaisedButton(
                            onPressed: () {
                              print(FormValues);
                              main(
                                  FormValues['email'].toString(),
                                  FormValues['password']
                                      .toString()); // use the email provided here
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 38, 47, 119),
                                    Color.fromARGB(200, 25, 150, 211)
                                  ])),
                              padding: const EdgeInsets.all(0),
                              child: const Text(
                                "INGRESAR",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ]))),
                ),
              )
            : loging(context));
  }

  @override
  void initState() {
    print("Conectando");
    initUniqueIdentifierState();
    super.initState();
  }

  Future<void> getArchivosURL() async {
    var responseurl = await http.get(Uri.parse("$url/GetURLFile"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    urlArchivos = responseurl.body;
    print("MI URL: " + urlArchivos.toString());
  }

  Future<void> initUniqueIdentifierState() async {
    print("INICIANDO SERVER");
    String identifier;

    try {
      identifier = (await UniqueIdentifier.serial)!;
      print(identifier);
      myIDuserAndroid = identifier;
      await getToken();
      await getArchivosURL();
      await verificar();
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;
    setState(() {
      myIDuserAndroid = identifier;
    });
  }

  Future<void> verificar() async {
    if (myIDuserAndroid != null && logout == false) {
      var response = await http.get(
          Uri.parse("$url/GetIdMovil?idandroid=" + myIDuserAndroid),
          headers: {"Authorization": "Bearer " + tokenApi.toString()});
      regVerficar = response.body;
      print("$url/GetIdMovil?idandroid=" + myIDuserAndroid);
      print("RESPUESTA: " + response.body);
      setState(() {
        //       print("NO IDENTIFICADO");
        isload = false;
        return;
      });
      //   if (response.body == "0") {
      //     setState(() {
      //       print("NO IDENTIFICADO");
      //       isload = false;
      //       return;
      //     });
      //   } else {
      //     response = await http.get(
      //         Uri.parse("$url/loginAndroid?IdAndroid=" +
      //             myIDuserAndroid +
      //             "&idUser=" +
      //             regVerficar +
      //             "&token=" +
      //             token),
      //         headers: {"Authorization": "Bearer " + tokenApi.toString()});
      //     print(
      //       "$url/loginAndroid?IdAndroid=" +
      //           myIDuserAndroid +
      //           "&idUser=" +
      //           regVerficar +
      //           "&token=" +
      //           token.toString(),
      //     );
      //     print(response.body);
      //     if (response.body == "R02") {
      //       response = await http.get(
      //           Uri.parse("$url/GetUserMovilDirectCliente?id=" + regVerficar),
      //           headers: {"Authorization": "Bearer " + tokenApi.toString()});
      //       userbody = jsonDecode(response.body);
      //           String userid="999";
      //       response = await http.get(
      //           Uri.parse(
      //               "$url/despachos?dato=$userid&id=${userbody["IdCliente"]}"),
      //           headers: {"Authorization": "Bearer " + tokenApi.toString()});
      //       jsonBody = jsonDecode(response.body);
      //       print(jsonBody);
      //       bodyJsonDespachos = jsonBody;
      //       listaDespachos = jsonBody;
      //       if (userbody != null) {
      //         response = await http.get(
      //             Uri.parse("$url/UpdateDBUser?id=${userbody["IdCliente"]}"),
      //             headers: {"Authorization": "Bearer " + tokenApi.toString()});
      //         FormValues.clear();
      //         if (bodyJsonDespachos != null) {
      //           Navigator.of(context).pushReplacement(MaterialPageRoute(
      //               builder: (context) => MyHomePage(listaDespachos)));
      //           print("INGRESANDO A BODY DESPACHOS");
      //         } else {
      //           setState(() {
      //             isload = false;
      //             return;
      //           });
      //         }
      //       } else {
      //         print("TIEMPO VENCIDO");
      //         setState(() {
      //           isload = false;
      //           return;
      //         });
      //       }
      //     } else {
      //       print("TIEMPO VENCIDO r03");
      //       setState(() {
      //         isload = false;
      //         return;
      //       });
      //     }
      //   }
    }
  }

  Future<void> main(String emal, String password) async {
    if (emal != '' && password != '') {
      FocusScope.of(context).unfocus();
      await Future.delayed(Duration(milliseconds: 400));
      setState(() {
        isload = true;
        logout = false;
      });
     String urlUserLink = "$url/api/Login/getmovil?";
        String urlUser = "User=$emal&";
        String urlPassword = "password=$password&";
        String usrlTipo = "tipo=SOCIO";
        var response = await http.get(
            Uri.parse(urlUserLink + urlUser + urlPassword + usrlTipo),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        print(urlUserLink + urlUser + urlPassword + usrlTipo);
      print(urlUserLink + urlUser + urlPassword + usrlTipo);
      dynamic jsonUsers = jsonDecode(response.body);
      print(jsonUsers);
      userbody = jsonUsers;
      if (jsonUsers.length > 0) {
        var response = await http.get(
            Uri.parse(
              "$url/UpdateDBUser?id=${jsonUsers["IdCliente"]}",
            ),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        response = await http.get(
            Uri.parse("$url/loginAndroid?IdAndroid=" +
                myIDuserAndroid.toString() +
                "&idUser=" +
                regVerficar +
                "&token=" +
                token),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        print("INICIANDO AL DESPACHO");
        //173380028
        //hpm3d

        //listaenproceso
        //  String userid='999';
        response = await http.get(
            Uri.parse("$url/cantidaddespachos?id=${userbody["IdCliente"]}"),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        cantidaddetramites = jsonDecode(response.body);
        print(cantidaddetramites[0]["enproceso"]);
        response = await http.get(Uri.parse("$url/listaestados"),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        listaestados = jsonDecode(response.body);
        print(listaestados);
        //       jsonBody = jsonDecode(response.body);
        // bodyJsonDespachos = jsonBody;
        // listaDespachos = jsonBody;
        //  response = await http.get(
        //       Uri.parse(
        //           "$url/despachosproceso?dato=$userid&id=${userbody["IdCliente"]}"),
        //       headers: {"Authorization": "Bearer " + tokenApi.toString()});
        //       listaenproceso=jsonDecode(response.body);
        // print(response.body);
        // setState(() {
        //   isload = true;
        //   logout = false;
        // });
        // // print(userbody["IdCargo"]);
        
        FormValues.clear();
        //if (bodyJsonDespachos != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MyHomePage(listaDespachos)));
        setState(() {
          isload = false;
        });
        //}
      } else {
        setState(() {
          isload = false;
          return;
        });
      }
    } else {
      setState(() {
        isload = false;
      });
    }
  }

  void cargarItems() async {
    String userid = "999";
    var response = await http.get(
        Uri.parse("$url/despachos?dato=$userid&id=${userbody["IdCliente"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    print(response.body);
    setState(() {
      isload = true;
      logout = false;
    });
    print(userbody["IdCargo"]);
    jsonBody = jsonDecode(response.body);
    bodyJsonDespachos = jsonBody;
    listaDespachos = jsonBody;
    FormValues.clear();
    if (bodyJsonDespachos != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage(listaDespachos)));
      setState(() {
        isload = false;
      });
    }
  }

  Future<void> getToken() async {
    print("INGRESANDO A OBTENER TOKEN");
    var response = await http.get(Uri.parse(
        "$url/api/Users/token?IdAndroid=" +
            myIDuserAndroid.toString()));
    tokenApi = response.body.toString();
    print("MI TOKEN:" + tokenApi.toString());
  }
}
