import 'dart:convert';

import 'package:app_universal/Screens/Components/Dashboard/hotel_app_theme.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/despacho_info_card.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/un_despacho_details.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class BusquedaScreen extends StatefulWidget {
  BusquedaScreen();
  @override
  _BusquedaScreenState createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  // final ScrollController _scrollController = ScrollController();
  bool touchUser = false;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  dynamic listanuevadespachos = [];
  List<String> _list = [];
  List<int> searchListNumerator = [];
  List<int> auxsearchListNumerator = [];
  bool isSearching = false;
  String searchText = "";
  Icon actionIcon = const Icon(
    FontAwesomeIcons.magnifyingGlass,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();

  void buildSearchList() {
    print("ENTRADNO A BUSCAR");
    if (searchText.isEmpty) {
    } else {
      List<int> aux = [];
      searchListNumerator = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toUpperCase().contains(searchText.toUpperCase())) {
          aux.add(i);
          print(i);
        }
      }
      setState(() {
        searchListNumerator = aux;
      });
    }
  }

  // void _handleSearchStart() {
  //   setState(() {
  //     isSearching = true;
  //   });
  // }

  // void _handleSearchEnd() {
  //   setState(() {
  //     actionIcon = const Icon(
  //       Icons.search,
  //       color: Colors.white,
  //     );
  //     isSearching = false;
  //     _searchQuery.clear();
  //   });
  // }

  void init() {
    _list = [];
    if (bodyJsonDespachos != null) {
      for (int i = 0; i < bodyJsonDespachos.length; i++) {
        _list.add(
          "${bodyJsonDespachos[i]["tram"]}/${bodyJsonDespachos[i]["codAduana"]}/${bodyJsonDespachos[i]["nroC"]}/${bodyJsonDespachos[i]["docEmb"]}/${bodyJsonDespachos[i]["razonSocial"]}/${bodyJsonDespachos[i]["docEmb"]}/${bodyJsonDespachos[i]["prov"]}",
        );
        searchListNumerator.add(i);
      }
      //  for (int i = 0; i<listaenproceso.length;i++) {
      //   int cont=listanuevadespachos.length+i;
      //   _list.add(
      //     "${listaenproceso[i]["tram"]}/${listaenproceso[i]["codAduana"]}/${listaenproceso[i]["nroC"]}/${listaenproceso[i]["docEmb"]}//${listaenproceso[i]["razonSocial"]}/${listaenproceso[i]["docEmb"]}/${listaenproceso[i]["prov"]}",
      //   );
      //   searchListNumerator.add(cont);
      // }
    }
  }

  @override
  void initState() {
    // animationController = AnimationController(
    //     duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    // isSearching = true;
    //init();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getSearchBarUI(),
              isSearching == true
                  ? Center(
                      child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Cargando tramites...",
                        style: TextStyle(
                            color: primaryColor, fontStyle: FontStyle.italic),
                      )
                    ]))
                  : Expanded(
                      child: Container(
                          color:
                              HotelAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                                      // separatorBuilder:
                                      //     (BuildContext context,
                                      //             int index) =>
                                      //         const Divider(
                                      //   color: Colors.black,
                                      // ),
                                      itemCount: listanuevadespachos.length,
                                      padding: const EdgeInsets.only(top: 0),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int i) =>
                                              GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            final route = MaterialPageRoute(
                                                builder: ((context) =>
                                                    UnDespachoDetails(
                                                        listanuevadespachos[
                                                            i])));
                                            Navigator.push(context, route);
                                          });
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Column(
                                            children: [
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title:
                                                    "${listanuevadespachos[i]["tram"]} | ${listanuevadespachos[i]["codAduana"]} | ${listanuevadespachos[i]["nroC"]} | ${listanuevadespachos[i]["codPatron"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title:
                                                    "${listanuevadespachos[i]["razonSocial"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title:
                                                    "NRO. DE ORDEN: ${listanuevadespachos[i]["nroSeguimiento"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title:
                                                    "F.COM: ${listanuevadespachos[i]["fCom"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title:
                                                    "PROVEEDOR: ${listanuevadespachos[i]["prov"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                              DespachoInfoCard(
                                                svgSrc:
                                                    "assets/icons/circulo.svg",
                                                title: "ESTADO: " +
                                                    "${listanuevadespachos[i]["estado"]}",
                                                amountOfFiles: "",
                                                numOfFiles: "",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))),
            ]));
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 80,
        title: Row(
          children: [Text("Busqueda de tramites")],
        ));
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color.fromARGB(255, 54, 52, 52).withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    
                    onChanged: (String txt) {
                      setState(() {
                         //_handleSearchStart();
                         searchText = txt;
                      });
                      // print(searchText);
                      // buildSearchList();
                    },
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Introduzca referencia del tramite...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(0.0),
                ),
                onTap: () async{
                  FocusScope.of(context).unfocus();
                  await Future.delayed(Duration(milliseconds: 400));
                  setState(() {
                    isSearching = true;
                  });
                  ///busquedaGralCliente?texto=711&idcliente=362
                  var response= await http.get(Uri.parse("$url/busquedaGralCliente?texto=$searchText&idcliente=${userbody["IdCliente"]}"),
                 headers: {"Authorization": "Bearer " + tokenApi.toString()});
                 setState(() {
                   listanuevadespachos=jsonDecode(response.body);
                   isSearching=false;
                 });

                },
                child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: SizedBox(
                      width: 20,
                      child: Icon(
                        Icons.search,
                        color: white,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
