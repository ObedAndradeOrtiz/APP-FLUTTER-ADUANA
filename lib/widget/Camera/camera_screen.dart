// ignore_for_file: deprecated_member_use, unused_local_variable, non_constant_identifier_names, unnecessary_statements

import 'dart:convert';
import 'dart:io';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/PageBotones.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/un_despacho_details.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/drawer/home_drawer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
List<String> listaFile = [];
int cont = 0;
String code = '';
File? images;
bool reintentar = false;
final picker = ImagePicker();
List<File>? imagesList;
List<File> imagePaths = [];
int Dim = 0;
dynamic _detalleDespacho;
dynamic _boton;
bool subiendo = false;
String _num = "";
bool volver = false;

class CameraScreen extends StatefulWidget {
  CameraScreen(dynamic detalleDespacho, dynamic boton, String num, {Key? key})
      : super(key: key) {
    _detalleDespacho = detalleDespacho;
    _boton = null;
    _boton = boton;
    _num = "";
    _num = num;
    volver = false;
    print(_detalleDespacho);
    print(_num);
  }
  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();

  void recargar() {
    _num;
  }
}

class _CameraScreenState extends State<CameraScreen> {
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

  @override
  void initState() {
    super.initState();
    _num = numeroConst;
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
        "${_boton["categoria"]}-${_boton["prefijo"]}${_detalleDespacho["tram"]}" +
            hora +
            milisegundo +
            numX.toString() +
            "X" +
            ".jpg"); //1
    listaFile.add(
        "\\DATAGORA-APP\\REGISTRO_CLIENTES\\${_detalleDespacho["idCliente"]}\\${_detalleDespacho["tram"]}\\CATEGORIA ${_boton["categoria"]}"); //2
    listaFile.add(_detalleDespacho["idSolicitud"].toString()); //idReference 3
    listaFile.add(numeroConst); //Type Reference 4
    listaFile.add("NTFRET"); //Formate 5
    listaFile.add(_boton["estado"].toString()); //Estate 6
    listaFile.add("1"); //HABILITADO// 7
    listaFile.add("0");
    var multipartFile = http.MultipartFile('formFile', stream, length,
        filename:
            //DATAGORA\REGISTRO_CLIENTES
            "\\DATAGORA-APP\\REGISTRO_CLIENTES\\${_detalleDespacho["idCliente"]}\\${_detalleDespacho["tram"]}\\CATEGORIA ${_boton["categoria"]}\\${_boton["categoria"]}-${_boton["prefijo"]}${_detalleDespacho["tram"]}" +
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
            headers: {'Content-Type': 'application/json',"Authorization":"Bearer "+tokenApi.toString()});
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

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("$command is not load");
    }
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
        Navigator.of(contextoPrncipal)
            .pop(PageDespachoBotones(_detalleDespacho));
      });
    } else {
      Dim = cont;
      reintentar = true;
      subiendo = false;
    }
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

  @override
  Widget build(BuildContext context) {
    return subiendo == true
        ? Scaffold(
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
                                  color: primaryColor, fontWeight: FontWeight.w700),
                            )), // Your footer widget
                      )),
                    ],
                  )),
            )))
        : volver == false
            ? WillPopScope(
                onWillPop: () async {
                  final shouldPop = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Aun no se han enviado las imagenes'),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Volver'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(contextoPrncipal, true);
                            },
                            child: const Text('Salir'),
                          ),
                        ],
                      );
                    },
                  );
                  return shouldPop!;
                },
                child: Scaffold(
                  appBar: AppBar(
                      toolbarHeight: 80,
                      backgroundColor: primaryColor,
                      title: Center(
                          child: _boton != null
                              ? Text("CATEGORIA ${_boton["categoria"]}",
                                  textAlign: TextAlign.start)
                              : Center())),
                  drawer: const Drawer(
                    width: 250,
                    child: HomeDrawer(),
                  ),
                  body: reintentar == false
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Form(
                              child: Column(
                                children: [
                                  Text("@Ágora-Soluciones-2022"),
                                  const SizedBox(height: 5),
                                  ElevatedButton(
                                      onPressed: () {
                                        opciones(context);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => primaryColor)),
                                      child: const SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: Center(
                                            child: Text("MENU DE IMAGEN")),
                                      )),
                                  //
                                  images == null
                                      ? const Center()
                                      : SizedBox(
                                          height: 450,
                                          child: ListView.builder(
                                              itemCount: imagePaths.length,
                                              itemBuilder: (_, i) => Column(
                                                    children: [
                                                      Image.file(imagePaths[i]),
                                                      // Image.asset(imagePaths[i]),
                                                    ],
                                                  )),
                                        ),
                                  images == null
                                      ? Center()
                                      : Center(
                                          child: Column(
                                            children: [
                                              RaisedButton(
                                                  onPressed: () {
                                                    enviarImages();
                                                    return setState(() {
                                                      subiendo = true;
                                                    });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80.0)),
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Ink(
                                                    decoration:
                                                        const BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: <Color>[
                                                          Color(0xFF0D47A1),
                                                          Color(0xFF1976D2),
                                                          Color(0xFF42A5F5),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  80.0)),
                                                    ),
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 88.0,
                                                              minHeight:
                                                                  50.0), // min sizes for Material buttons
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        "ENVIAR IMAGEN(ES)",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  )),
                                              // Your footer widget
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        )
                      : AlertDialog(
                          title: const Text('¡Fallo al enviar imagenes!'),
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          actions: [
                            TextButton(
                              onPressed: () {
                                enviarImages();
                                return setState(() {
                                  subiendo = true;
                                  reintentar = false;
                                });
                              },
                              child: const Center(child: Text('Reintentar')),
                            ),
                          ],
                        ),
                ))
            : restaurarVista();
  }

  Widget restaurarVista() {
    return UnDespachoDetails(_detalleDespacho);
  }

  guardarrutaderchivo() async {
    listaFile
        .add("${_boton["prefijo"]}${_detalleDespacho["tram"]}($num).jpg"); //1
    listaFile.add(
        "\\DATAGORA\\REGISTRO_CLIENTES\\${_detalleDespacho["idCliente"]}\\${_detalleDespacho["tram"]}\\CATEGORIA ${_boton["categoria"]}"); //2
    listaFile.add(_detalleDespacho["idCliente"]); //idReference 3
    listaFile.add(_boton["idAppCatXCliente"].toString()); //Type Reference 4
    listaFile.add("APP"); //Formate 5
    listaFile.add(_boton["estado"].toString()); //Estate 6
    listaFile.add("1"); //HABILITADO// 7
    var save = await http.post(
        Uri.parse(
            "http://tramites.rysbolivia.com:5001/save/archivos/save/archivos"),
        body: json.encode("hola"),
        headers: {'Content-Type': 'application/json',"Authorization":"Bearer "+tokenApi.toString()});
    print(save.statusCode);
    print(url + "/save/archivos");
  }
}
