// ignore_for_file: unused_element, body_might_complete_normally_nullable, deprecated_member_use, unnecessary_statements

import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/PageDetalles.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/chatDespacho.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/drawer/home_drawer.dart';
import 'package:app_universal/global/theme.dart';
import 'package:app_universal/widget/Camera/camera_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Pages/archivos.dart';

dynamic _detalleDespacho;
dynamic _botonesDespachos;
dynamic jsonBody;
dynamic _imagenesList;
List<dynamic> _imagenesListGeneral = [];
List<int> _numerosList = [];
bool hayImagen = false;
bool recargarBotones = false;

Widget _showPage = PageDetalles(_detalleDespacho);
dynamic _milista;
class UnDespachoDetails extends StatefulWidget {
  UnDespachoDetails(detallesDespacho, {Key? key}) : super(key: key) {
    _detalleDespacho = detallesDespacho;
   // recargarPage = true;
    // if (recargarPage == true) {
    //   _botonesDespachos = [];
    //   jsonBody = null;
    //   _imagenesList = [];
    //   _imagenesListGeneral = [];
    //   _numerosList = [];
    //   hayImagen = false;
    //   recargarBotones = false;
    //   recargarPage = false;
    // }

    print(_detalleDespacho);
  }
  @override
  _UnDespachoDetails createState() => _UnDespachoDetails();
}

class _UnDespachoDetails extends State<UnDespachoDetails> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _pageIndex = 0;
  int cambiar = 0;
  bool enviando = false;
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool isSearching = false;
  String searchText = "";
  List<String> _list = [];
  List<int> searchListNumerator = [];
  List<int> auxsearchListNumerator = [];
  Widget? _pageChooser(int page) {
    switch (page) {
      case 0:
        {
          isSearching = false;
          searchText = "";
          _list = [];
          searchListNumerator = [];
          auxsearchListNumerator = [];
          _handleSearchEnd();
          return PageDetalles(_detalleDespacho);
        }

      // case 1:
      //   {
      //     searchText = "";
      //     _list = [];
      //     searchListNumerator = [];
      //     auxsearchListNumerator = [];
      //     isSearching = false;
      //     _handleSearchEnd();
      //     return TaskScreen() ;
      //   }

      case 1:
        {
          searchText = "";
          _list = [];
          searchListNumerator = [];
          auxsearchListNumerator = [];
          isSearching = false;
          _handleSearchEnd();
          //init();
          return  Myfiles(_milista,_detalleDespacho);
        }
        case 2:{
          return ChatDespacho();
        }
    }
  }
void cagarLista() async {
    
  }
  void cargarBotones() async {
    var responde = await http.get(
        Uri.parse("$url/listaarchivos?id=${_detalleDespacho["idSolicitud"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
         _milista = jsonDecode(responde.body);
        
         //_milista = jsonDecode(responde.body);
    if (_milista != null) {
      _milista = jsonDecode(responde.body);
       responde = await http.get(
        Uri.parse("$url/listaarchivosCliente?id=${_detalleDespacho["idSolicitud"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
        print(responde.body);
      setState(() {
          _milista;
          listaarchivosCliente=jsonDecode(responde.body);
      });
     
    var response = await http.get(
        Uri.parse("$url/botonesdespachos?id=${_detalleDespacho["idCliente"]}"),headers: {"Authorization":"Bearer "+tokenApi.toString()});
    _botonesDespachos = jsonDecode(response.body);
    var _notificacion = await http.get(Uri.parse("$url/notificaciones"),headers: {"Authorization":"Bearer "+tokenApi.toString()});
    listaNotificaiones = jsonDecode(_notificacion.body);
    listaNotificaionesAux = listaNotificaiones;
    init();
    print(_botonesDespachos.length);
    if (_botonesDespachos != null) {
      var response;
      int cont = _botonesDespachos.length;
      for (int i = 0; i < _botonesDespachos.length; i++) {
        response = await http.get(Uri.parse(
            "$url/GetCantArchivos?idreferencia=" +
                _detalleDespacho["idSolicitud"].toString() +
                "&tipoRef=" +
                _botonesDespachos[i]["idAppCatXCliente"].toString()),headers: {"Authorization":"Bearer "+tokenApi.toString()});
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
    }}
    recargar();
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

  void recargar() {
    return setState(() {});
  }

  @override
  void initState() {
    cargarBotones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color cambiarColor(int cont) {
      if (cont == 0) {
        cambiar = 1;
        return Color.fromARGB(218, 31, 53, 151);
      } else {
        cambiar = 0;
        return Color.fromARGB(255, 75, 188, 253);
      }
    }

    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('¿Desea salir del detalle de despacho?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      _imagenesListGeneral = [];
                      _botonesDespachos = [];
                      jsonBody = null;
                      _imagenesList = [];
                      _imagenesListGeneral = [];
                      _numerosList = [];
                      hayImagen = false;
                      recargarBotones = false;
                      recargarPage = true;
                      _pageIndex = 1;
                      Navigator.pop(context, true);
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
        child: Scaffold(
            appBar: _pageIndex == 2
                ? buildBar(context)
                : AppBar(
                    title: Text("Despacho ${_detalleDespacho["tram"]}"),
                    toolbarHeight: 80.0,
                    backgroundColor: primaryColor,
                    centerTitle: true,
                  ),
            drawer: const Drawer(
              width: 250,
              child: HomeDrawer(),
            ),
            
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 60.0,
              items: <Widget>[
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.solidFileLines,
                  size: 30,
                  color: Colors.white,
                ),
                Text("Detalle",style: TextStyle(color: white, fontSize: 9),),]),
              //   Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              //   Icon(
              //     FontAwesomeIcons.tasks,
              //     size: 30,
              //     color: Colors.white,
              //   ),
              //   Text("Task",style: TextStyle(color: white, fontSize: 9)),
              //   ]),
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.folderOpen,
                  size: 30,
                  color: Colors.white,
                ),
                Text("Archivos",style: TextStyle(color: white, fontSize: 9)),]),
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_sharp,
                  size: 30,
                  color: Colors.white,
                ),
                Text("Chat",style: TextStyle(color: white, fontSize: 9)),])
              ],
              color: Color.fromARGB(255, 36, 45, 84),
              buttonBackgroundColor: Color.fromARGB(255, 75, 188, 253),
              backgroundColor: Color.fromARGB(218, 31, 53, 151),
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 700),
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              letIndexChange: (index) => true,
            ),
            body: _pageIndex != 2 || isSearching == false
                ? _pageChooser(_pageIndex)
                : enviando == false
                    ? Column(children: [
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: ListView.builder(
                                itemCount: searchListNumerator.length,
                                itemBuilder: (context, i) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Center(
                                              child: Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.05,
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            decoration: BoxDecoration(
                                              color: cambiarColor(cambiar),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(children: [
                                              Text(
                                                listaNotificaiones[
                                                        searchListNumerator[i]]
                                                    ["descripcion"],
                                                style: TextStyle(
                                                    color: Colors.white),
                                                maxLines: 1,
                                              ),
                                              Spacer(),
                                              Text(
                                                "Enviar",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              IconButton(
                                                alignment: Alignment.topRight,
                                                onPressed: () {
                                                  setState(() {
                                                    enviando = true;
                                                  });
                                                  enviarMensaje(
                                                      listaNotificaiones[i]
                                                          ["descripcion"]);
                                                },
                                                icon: Icon(Icons.send_rounded,
                                                    color: Colors.white),
                                              ),
                                            ]),
                                          ))
                                        ])))
                      ])
                    : Scaffold(
                        body: SafeArea(
                            child: Center(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: FractionallySizedBox(
                                      widthFactor: 0.9,
                                      child: Image.asset(
                                       logogeneral,
                                        scale: 5,
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
                      )))));
  }
  _UnDespachoDetails() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          searchText = "";
        });
      } else {
        setState(() {
          searchListNumerator = [];
          searchText = _searchQuery.text;
          buildSearchList();
        });
      }
    });
  }
  void enviarMensaje(String descripcion) async {
    String mensaje = "NOTIFICACION:|" +
        descripcion +
        "NRO. TRAMITE: ${_detalleDespacho['tram']}" +
        "FCOM: ${_detalleDespacho['fCom']}  /DOC.EMB: ${_detalleDespacho['docEmb']}  / |PROV:  ${_detalleDespacho['prov']}   | MERCADERIA: ${_detalleDespacho['mERCADERIA']} " +
        "|USUARIO: ${userbody["Nombres"]}";
    var response = await http.get(
      Uri.parse("$url/mensajes?message=" + mensaje),
    );
    if (response.statusCode == 200) {
      setState(() {
        enviando = false;
      });
    }
  }

  Widget appBarTitle = const Text(
    "Notificaciones Despachos",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  void buildSearchList() {
    if (searchText.isEmpty || searchText == "") {
    } else {
      searchListNumerator = [];
      listaNotificaionesAux = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(searchText.toLowerCase())) {
          searchListNumerator.add(i);
        }
      }
      setState(() {
        for (int i = 0; i < searchListNumerator.length; i++) {
          print(searchListNumerator[i]);
        }
      });
    }
  }
  void init() async {
    _list = [];
    if (bodyJsonDespachos != null) {
      for (int i = 0; i < listaNotificaiones.length; i++) {
        _list.add(
          "${listaNotificaiones[i]["descripcion"]}",
        );
        searchListNumerator.add(i);
      }
    }
    setState(() {
      _list;
    });
  }
  AppBar buildBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 80.0,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    decoration: const InputDecoration(
                      hintText: "Buscar",
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }
  void _handleSearchStart() {
    setState(() {
      searchText = "";
      isSearching = true;
    });
  }
  void _handleSearchEnd() {
    setState(() {
      isSearching = false;
      listaNotificaionesAux = listaNotificaiones;
      searchText = "";
      actionIcon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = Text(
        "Despacho ${_detalleDespacho["tram"]}",
        style: TextStyle(color: Colors.white),
      );
      _searchQuery.clear();
    });
  }
}
