// ignore_for_file: non_constant_identifier_names, unused_element, deprecated_member_use, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';

dynamic _detalleDespacho;
List<String> listaFile = [];
int cont = 0;
String code = '';
File? images;
bool reintentar = false;
final picker = ImagePicker();
List<File>? imagesList;
List<File> imagePaths = [];
int Dim = 0;
dynamic _boton;
bool subiendo = false;
String _num = "";
bool volver = false;

class PageNotificacion extends StatefulWidget {
  PageNotificacion(dynamic detalleDespacho, {Key? key}) : super(key: key) {
    _detalleDespacho = detalleDespacho;
    recargarPage = true;
  }

  @override
  State<PageNotificacion> createState() => _PageNotificacion();
}

class _PageNotificacion extends State<PageNotificacion> {
  final myController = TextEditingController();
  String descripcion = "";
  String monto = "";
  String seleccionado = "Seleccione tipo";
  String seleccionado1 = "Seleccione opcion";
  List<String> listaNotif1 = [
    "SOLICITUD",
    "CONFIRMACION",
    "NOTIFICACION",
  ];
  List<String> listaNotif = [];
  @override
  void initState() {
    for (int i = 0; i < listaNotificaiones.length; i++) {
      listaNotif.add(listaNotificaiones[i]["descripcion"].toString());
    }
    super.initState();
    myController.addListener(_printLatestValue);
    _num = numeroConst;
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  int cambiar = 0;
  bool enviando = false;
  var pickedFile;
  var dio = Dio();
  Future selImagen(op) async {
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else if (op == 2) {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    recargar();
  }

  Future<void> uploadImage1(File image, int numX) async {
    listaFile = [];
    print(numX);
    print("intentando subir");
    DateTime now = DateTime.now();
    String hora = DateTime.now().hour.toString();
    String milisegundo = DateTime.now().microsecondsSinceEpoch.toString();

    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse("$url/archivos");
    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    listaFile.add(
        "$seleccionado-$seleccionado1${_detalleDespacho["tram"]}" +
            hora +
            milisegundo +
            numX.toString() +
            "X" +
            ".jpg"); //1
    listaFile.add(
        "\\DATAGORA-APP\\REGISTRO_CLIENTES\\${_detalleDespacho["idCliente"]}\\${_detalleDespacho["tram"]}\\"+seleccionado+"\\"+seleccionado1); //2
    listaFile.add(_detalleDespacho["idSolicitud"].toString()); //idReference 3
    listaFile.add(numeroConst); //Type Reference 4
    listaFile.add("NOTIFAPP"); //Formate 5
    listaFile.add("A"); //Estate 6
    listaFile.add("1"); //HABILITADO// 7
    listaFile.add("0");//ID REFERENCIA 
    var multipartFile = http.MultipartFile('formFile', stream, length,
        filename:
            //DATAGORA\REGISTRO_CLIENTES
            "\\DATAGORA-APP\\REGISTRO_CLIENTES\\${_detalleDespacho["idCliente"]}\\${_detalleDespacho["tram"]}\\$seleccionado\\$seleccionado1\\$seleccionado-$seleccionado1${_detalleDespacho["tram"]}"+
                hora +
                milisegundo +
                numX.toString() +
                "X" +
                ".jpg");
    print(multipartFile.filename);
    request.files.add(multipartFile);
    await request.send().then((response) async {
      print("intentando subir");
      print(url + "/save/archivos");
      var save;
      if (response.statusCode == 200) {
        //await guardarrutaderchivo();
        save = await http.post(Uri.parse(url + "/save/archivos"),
            body: json.encode(listaFile),
            headers: {
              'Content-Type': 'application/json',
              "Authorization": "Bearer " + tokenApi.toString()
            });
      }
      if (save.statusCode != 200) {
        setState(() {
          reintentar = true;
        });
      } else {
        setState(() {});
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(response.statusCode);
        print("UPLOAD!!!");
      });
    }).catchError((e) {
      print("NO UPLOAD!!!");
      setState(() {
        reintentar = true;
      });
    });
  }

  void recargar() {
    return setState(() {
      Dim++;
      if (pickedFile != null) {
        images = File(pickedFile.path);
        imagePaths.add(images!);
      } else {}
    });
  }

  void enviarImages() async {
    cont = Dim;
    if (imagePaths.length > 0) {
      for (int i = 0; i < imagePaths.length; i++) {
        await uploadImage1(imagePaths[i], i);
        print("SUBIENDO");
        Dim--;
      }
      if (reintentar != true) {
        return setState(() {
          List<File> aux = [];
          listaFile = [];
          imagePaths = aux;
          subiendo = false;
          reintentar = false;
          cont = 0;
          Dim = 0;
          images = null;
          _boton = null;
          _num = numeroConst;
          recargarPage = true;
          // Navigator.of(contextoPrncipal)
          //     .pop(PageDespachoBotones(_detalleDespacho));
        });
      } else {
        Dim = cont;
        reintentar = true;
        subiendo = false;
      }
    }
    // enviarMensaje(
    //   descripcion,
    //   monto,
    //   seleccionado,
    //   seleccionado1,
    // );
  }

  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return enviando == false
        ? SafeArea(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      DropdownButton(
                          iconSize: 35,
                          elevation: 15,
                          dropdownColor: Colors.amber,
                          iconDisabledColor: Colors.amber,
                          iconEnabledColor: Color.fromARGB(255, 7, 255, 48),
                          hint: Text(seleccionado),
                          items: listaNotif1.map((String a) {
                            return DropdownMenuItem(
                                value: a,
                                child: Column(children: [Text(a), Divider()]));
                          }).toList(),
                          onChanged: ((value) {
                            setState(() {
                              seleccionado = value.toString();
                            });
                          })),
                      DropdownButton(
                          iconSize: 35,
                          elevation: 15,
                          dropdownColor: Colors.amber,
                          iconDisabledColor: Colors.amber,
                          iconEnabledColor: Color.fromARGB(255, 7, 255, 48),
                          hint: Text(seleccionado1),
                          items: listaNotif.map((String a) {
                            return DropdownMenuItem(value: a, child: Text(a));
                          }).toList(),
                          onChanged: ((value) {
                            setState(() {
                              seleccionado1 = value.toString();
                            });
                          })),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                descripcion = value;
                                value = "";
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Descripcion',
                              hintText: '',
                            ),
                            autofocus: false,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 300,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                monto = value;
                                value = "";
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Monto Bs.',
                              hintText: '',
                            ),
                            autofocus: false,
                          )),
                      SizedBox(
                        height: 45,
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: RaisedButton(
                            onPressed: () {
                              //enviarImages();
                              return setState(() {
                                opciones(context);
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(255, 13, 161, 25),
                                    Color.fromARGB(255, 13, 161, 25),
                                    Color.fromARGB(255, 13, 161, 25),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth: 88.0,
                                    minHeight:
                                        50.0), // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: const Text(
                                  "CARGAR IMAGEN(ES)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      images == null
                          ? const Center()
                          : SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imagePaths.length,
                                  itemBuilder: (_, i) => Row(
                                        children: [
                                          SizedBox(
                                              height: 250,
                                              child: Image.file(imagePaths[i])),
                                          SizedBox(
                                            width: 15,
                                          )
                                        ],
                                      )),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: RaisedButton(
                              onPressed: () {
                                if (seleccionado == "Seleccione tipo" ||
                                    seleccionado1 == "Seleccione opcion") {
                                  return AlertFalta(context);
                                } else {
                                  setState(() {
                                    enviando = true;
                                  });
                                  enviarImages();
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0,
                                      minHeight:
                                          50.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "ENVIAR NOTIFICACION(ES)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))),
                    ])))
        : Scaffold(
            backgroundColor: white,
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
                              "Desarrollado por Ágora",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w700),
                            )), // Your footer widget
                      )),
                    ],
                  )),
            )));
  }

  void AlertFalta(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Text("SELECCIONE TIPO U OPCION!",
                                style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text("Retornar",
                                  style: TextStyle(fontSize: 16))),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selImagen(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text("Tomar foto",
                                  style: TextStyle(fontSize: 16))),
                          Icon(
                            Icons.camera_alt,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selImagen(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text("Seleccionar una foto",
                                  style: TextStyle(fontSize: 16))),
                          Icon(
                            Icons.image,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.white))),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Text("Cerrar Menu",
                                  style: TextStyle(fontSize: 16))),
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void enviarMensaje(
      String descripcion, String monto, String tipo, String opcion) async {
    String mensaje = "";
    if (descripcion != "" && monto != "") {
      mensaje = "NOTIFICACION:|" +
          tipo +
          opcion +
          "|NRO. TRAMITE: ${_detalleDespacho['tram']}" +
          "|FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   |MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
          "|DESCRIPCION: " +
          descripcion +
          "|MONTO:" +
          monto +
          "|USUARIO: ${userbody["Nombres"]}";
    }
    if (descripcion != "" && monto == "") {
      mensaje = "NOTIFICACION:|" +
          tipo +
          opcion +
          "|NRO. TRAMITE: ${_detalleDespacho['tram']}" +
          "|FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   |MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
          "|DESCRIPCION: " +
          descripcion +
          "|USUARIO: ${userbody["Nombres"]}";
    }
    if (descripcion == "" && monto != "") {
      mensaje = "NOTIFICACION:|" +
          tipo +
          opcion +
          "|NRO. TRAMITE: ${_detalleDespacho['tram']}" +
          "|FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   |MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
          "|MONTO:" +
          monto +
          " Bs." +
          "|USUARIO: ${userbody["Nombres"]}";
    }
    if (descripcion == "" && monto == "") {
      mensaje = "NOTIFICACION:|" +
          tipo +
          opcion +
          "|NRO. TRAMITE: ${_detalleDespacho['tram']}" +
          "|FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   |MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
          "|USUARIO: ${userbody["Nombres"]}";
    }

    var response = await http.get(Uri.parse("$url/mensajes?message=" + mensaje),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    return restornar();
  }

  void restornar() {
    return setState(() {
      descripcion = "";
      monto = "";
      seleccionado = "Seleccione tipo";
      seleccionado1 = "Seleccione opcion";
      enviando = false;
    });
  }
}
