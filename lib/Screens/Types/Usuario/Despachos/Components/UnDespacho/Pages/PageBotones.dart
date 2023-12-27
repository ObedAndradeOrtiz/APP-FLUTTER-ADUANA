// ignore_for_file: unused_element, unused_field, deprecated_member_use, unused_local_variable

import 'package:app_universal/Screens/Types/Usuario/MainDashboard/dashboard_main.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:app_universal/widget/Camera/camera_screen.dart';
import 'package:app_universal/widget/imagen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'PageDetalles.dart';

dynamic _detalleDespacho;
dynamic _botonesDespachos;
dynamic jsonBody;
dynamic _imagenesList;
List<dynamic> _imagenesListGeneral = [];
List<int> _numerosList = [];
bool hayImagen = false;
bool recargarBotones = false;
bool enviando = false;
int num = 1;

class PageDespachoBotones extends StatefulWidget {
  PageDespachoBotones(detallesDespacho, {Key? key}) : super(key: key) {
    _detalleDespacho = detallesDespacho;
    recargarPage = true;

    if (recargarPage == true) {
      _botonesDespachos = [];
      jsonBody = null;
      _imagenesList = [];
      _imagenesListGeneral = [];
      _numerosList = [];
      hayImagen = false;
      recargarBotones = false;
    }

    print(_detalleDespacho);
  }
  @override
  _PageDespachoBotones createState() => _PageDespachoBotones();
}

class _PageDespachoBotones extends State<PageDespachoBotones> {
  final PageDetalles _pageDetalles = PageDetalles(_detalleDespacho);

  late int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  void cargarBotones() async {
    var response = await http.get(
        Uri.parse("$url/botonesdespachos?id=${_detalleDespacho["idCliente"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    _botonesDespachos = jsonDecode(response.body);
    print(_botonesDespachos.length);
    if (_botonesDespachos != null) {
      var response;
      int cont = _botonesDespachos.length;
      for (int i = 0; i < _botonesDespachos.length; i++) {
        response = await http.get(
            Uri.parse("$url/GetCantArchivos?idreferencia=" +
                _detalleDespacho["idSolicitud"].toString() +
                "&tipoRef=" +
                _botonesDespachos[i]["idAppCatXCliente"].toString()),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
        if (response.body == "[]") {
          cont--;
          _imagenesListGeneral.add("no existe");
        } else {
          _imagenesListGeneral.add(jsonDecode(response.body));
        }

        print(response.body);
      }
      if (cont != 0) {
        hayImagen = true;
      }
    }
    setState(() {});
  }

  void openCamera(dynamic botonX) {
    numeroConst = botonX["idAppCatXCliente"].toString();
    print("numero constante");
    print(numeroConst);
    final route = MaterialPageRoute(
        builder: ((context) => CameraScreen(
            _detalleDespacho, botonX, botonX["idAppCatXCliente"].toString())));
    Navigator.push(context, route).then((value) => initState());
  }

  @override
  void initState() {
    cargarBotones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _botonesDespachos == null
        ? Center()
        : Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 15),
              child: Row(
                children: [
                  Text(
                    'Solo constancia de retiro de mercaderia',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryColor),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info,
                        color: primaryColor,
                      ))
                ],
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _botonesDespachos.length,
                itemBuilder: (context, i) => Column(children: [
                      GFAccordion(
                          showAccordion: false,
                          collapsedTitleBackgroundColor:
                              const Color(0xFFE0E0E0),
                          title: _botonesDespachos[i]["categoria"],
                          contentChild: Column(children: [
                            RaisedButton(
                              onPressed: () {
                                openCamera(_botonesDespachos[i]);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)),
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(200, 25, 150, 211),
                                      Color.fromARGB(200, 25, 150, 211)
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0.0)),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      minWidth: 88.0,
                                      minHeight:
                                          36.0), // min sizes for Material buttons
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Capturar " +
                                        _botonesDespachos[i]["categoria"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            _imagenesListGeneral == [] ||
                                    // ignore: unnecessary_null_comparison
                                    _imagenesListGeneral == null ||
                                    _imagenesListGeneral.isEmpty
                                ? const Text(
                                    "No hay imagen",
                                    style: TextStyle(color: Colors.amber),
                                  )
                                : _imagenesListGeneral[i] != "no existe"
                                    ? SizedBox(
                                        height: 140,
                                        child: ListView.builder(
                                            itemCount:
                                                _imagenesListGeneral[i].length,
                                            itemBuilder: (context, index) =>
                                                Column(children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      abrirImagen(i, index);
                                                    },
                                                    child: Text(
                                                        _imagenesListGeneral[i]
                                                            [index]["nombre"]),
                                                  ),
                                                  Divider(
                                                    color: blackColor,
                                                  )
                                                ])))
                                    : Text("No hay imagen",
                                        style: TextStyle(color: Colors.amber)),
                          ]))
                    ]))
          ])));
    // return ListView.builder(
    //     itemCount:  _botonesDespachos.length,
    //     itemBuilder: (context, i) => SingleChildScrollView(
    //                               child:Column(children: [
    //           GFAccordion(
    //                           showAccordion: false,
    //                           collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
    //                             title:  _botonesDespachos[i]["categoria"],
    //                             contentChild:Container(
    //           width: MediaQuery.of(context).size.width / 0.5,
    //           child: SizedBox(
    //             height: 120,
    //             child:  ListView.builder(
    //             itemCount: _imagenesListGeneral[i].length,
    //             itemBuilder: (context, index) => Column(
    //               children: [
    //                 Center(
    //                   child: Row(
    //                     children: [
    //                       Icon(
    //                         Icons.image,
    //                         color: primaryColor,
    //                         size: 25,
    //                       ),
    //                       Container(
    //                         width: MediaQuery.of(context).size.width / 1.2,
    //                         child: TextButton(
    //                             onPressed: () {
    //                               //abrirImagen(i);
    //                             },
    //                             child:Text("")
    //                             // _imagenesListGeneral[1]!= "no existe"?  Text(_imagenesListGeneral[i]["nombre"],
    //                             //     maxLines: 5,
    //                             //     style: TextStyle(
    //                             //         color: Color.fromARGB(255, 1, 1, 1),
    //                             //         fontSize: 13)):Center()
    //                                     ),
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ))))])));
  }

  void abrirImagen(int i, int index) async {
    print(url +
        "/dowloadimage?direccion=" +
        urlArchivos.toString() +
        "\\" +
        _imagenesListGeneral[i][index]["direccion"] +
        "\\" +
        "&name=" +
        _imagenesListGeneral[i][index]["nombre"]);
    Image imagen = Image.network(
      url +
          "/dowloadimage?direccion=" +
          urlArchivos.toString() +
          "\\" +
          _imagenesListGeneral[i][index]["direccion"] +
          "\\" +
          "&name=" +
          _imagenesListGeneral[i][index]["nombre"],
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.download,
                color: primaryColor,
              ),
              Text(
                "Descargando...",
                style: TextStyle(color: primaryColor),
              )
            ],
          )
        ]);
      },
    );
    var route = MaterialPageRoute(
        builder: ((context) =>
            MyImage(imagen, _imagenesListGeneral[i][index])));
    Navigator.push(context, route);
  }

  void entregarDocumento() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var response = await http.get(
        //http://agoranet.ddns.net:5001/entregadocumento?IdSolicitud=20208&IdUsuario=2609
        Uri.parse(
            "$url/entregadocumento?IdSolicitud=${_detalleDespacho["idSolicitud"]}&IdUsuario=${_detalleDespacho["idCliente"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    print(
        "$url/entregadocumento?IdSolicitud=${_detalleDespacho["idSolicitud"]}&IdUsuario=${_detalleDespacho["idCliente"]}");
    if (response.statusCode == 200) {
      enviarMensaje("Entrega de documentos ");
      print(
          "$url/despachos?dato=${userbody["IdCargo"]}?id=${userbody["IdCliente"]}");
       String userid="999";
          response = await http.get(
              Uri.parse(
                  "$url/despachos?dato=$userid&id=${userbody["IdCliente"]}"),
              headers: {"Authorization": "Bearer " + tokenApi.toString()});
      jsonBody = jsonDecode(response.body);
      print(jsonBody);
      bodyJsonDespachos = jsonBody;
      listaDespachos = jsonBody;
      setState(() {
        dispose();
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage(listaDespachos)));
    }
  }

  void enviarMensaje(String descripcion) async {
    String mensaje = "NOTIFICACION:|" +
        descripcion +
        "|NRO. TRAMITE: ${_detalleDespacho['tram']}" +
        "|FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   |MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
        "|USUARIO: ${userbody["Nombres"]}";
    var response = await http.get(Uri.parse("$url/mensajes?message=" + mensaje),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
  }

  void retirodoDocumento() async {
    await Future.delayed(Duration(milliseconds: 2000));
    var response = await http.get(
        Uri.parse(
            "$url/retirodocumento?IdSolicitud=${_detalleDespacho["idSolicitud"]}&IdUsuario=${_detalleDespacho["idCliente"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    print(
        "$url/retirodocumento?IdSolicitud=${_detalleDespacho["idSolicitud"]}&IdUsuario=${_detalleDespacho["idCliente"]}");
    print(
        "$url/entregadocumento?IdSolicitud=${_detalleDespacho["idSolicitud"]}&IdUsuario=${_detalleDespacho["idCliente"]}");
    if (response.statusCode == 200) {
      //enviarMensaje("Retiro de mercaderia");
      print(
          "$url/despachos?dato=${userbody["IdCargo"]}?id=${userbody["IdCliente"]}");
      //http://181.115.152.194:5001/despachos?dato=8&id=1053
       String userid="999";
          response = await http.get(
              Uri.parse(
                  "$url/despachos?dato=$userid&id=${userbody["IdCliente"]}"),
              headers: {"Authorization": "Bearer " + tokenApi.toString()});
      jsonBody = jsonDecode(response.body);
      print(jsonBody);
      bodyJsonDespachos = jsonBody;
      listaDespachos = jsonBody;
      setState(() {
        enviando = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage(listaDespachos)));
    }
  }

  void cargarImagenes() async {
    var response;

    for (int i = 0; i < _botonesDespachos.length; i++) {
      response = await http.get(
          Uri.parse("$url/GetCantArchivos?idreferencia=" +
              _botonesDespachos[i]["idCliente"] +
              "&tipoRef=" +
              _botonesDespachos[i]["idAppCatXCliente"]),
          headers: {"Authorization": "Bearer " + tokenApi.toString()});
      if (response.body != "[]") {
        _imagenesListGeneral.add(jsonDecode(response.body));
      }

      print(response.body);
    }
  }
}


//  RaisedButton(
//                                               onPressed: () {
//                                                 var route = MaterialPageRoute(
//                                                     builder: ((context) =>
//                                                         MyGalery(
//                                                             _imagenesListGeneral[
//                                                                 i])));
//                                                 Navigator.push(context, route);
//                                               },
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           80.0)),
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Ink(
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     gradient: LinearGradient(
//                                                       colors: <Color>[
//                                                         Color.fromARGB(
//                                                             255, 227, 139, 23),
//                                                         Color.fromARGB(
//                                                             255, 227, 139, 23),
//                                                         Color.fromARGB(
//                                                             255, 227, 139, 23),
//                                                       ],
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.all(
//                                                             Radius.circular(
//                                                                 80.0)),
//                                                   ),
//                                                   child: Container(
//                                                       constraints:
//                                                           const BoxConstraints(
//                                                               minHeight:
//                                                                   30.0), // min sizes for Material buttons
//                                                       alignment:
//                                                           Alignment.center,
//                                                       child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .center,
//                                                           children: const [
//                                                             Icon(
//                                                               Icons.file_open,
//                                                               color: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       255,
//                                                                       255,
//                                                                       255),
//                                                             ),
//                                                             Text(
//                                                               "Galeria de Archivos",
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .white),
//                                                             )
//                                                           ]))))

