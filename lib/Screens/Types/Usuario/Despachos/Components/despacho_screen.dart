// ignore_for_file: deprecated_member_use, duplicate_ignore, unused_import, unnecessary_statements

import 'dart:convert';

import 'package:app_universal/Screens/Components/Dashboard/hotel_app_theme.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/drawer/home_drawer.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'UnDespacho/despacho_info_card.dart';
import 'UnDespacho/un_despacho_details.dart';
import 'pages/busqueda.dart';

var _listaDespachos;
dynamic listanuevadespachos;
List<String> _list = [];
List<int> searchListNumerator = [];
List<int> auxsearchListNumerator = [];
bool isSearching = false;
String searchText = "";
String nroDespacho = "0";

class Despachos extends StatefulWidget {
  Despachos(listaDespachos, String nroLista, {Key? key}) : super(key: key) {
    _listaDespachos = listaDespachos;
    listanuevadespachos = _listaDespachos;
    nroDespacho = nroLista;
    // _list = [];
    // searchListNumerator = [];
    // auxsearchListNumerator = [];
    // isSearching = false;
    // searchText = "";
  }

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<Despachos> {
  final ScrollController _scrollController = ScrollController();

  Widget appBarTitle = Row(
    children: [
      Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(255, 46, 112, 156).withOpacity(0.6),
                  offset: const Offset(2.0, 4.0),
                  blurRadius: 40),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            child: Image.asset(
              logogeneral,
              color: Colors.white,
            ),
          )),
    ],
  );
  Icon actionIcon = const Icon(
    FontAwesomeIcons.magnifyingGlass,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();

  _SearchListState() {
    _searchQuery.addListener(() {});
  }
  @override
  void initState() {
    // init();
    //isSearching = false;
    super.initState();
  }

  void init() {
    _list = [];
    if (listanuevadespachos != null) {
      for (int i = 0; i < listanuevadespachos.length; i++) {
        _list.add(
          "${_listaDespachos[i]["tram"]}/${_listaDespachos[i]["codAduana"]}/${_listaDespachos[i]["nroC"]}/${_listaDespachos[i]["docEmb"]}",
        );
        searchListNumerator.add(i);
      }
      for (int i = 0; i < listaenproceso.length; i++) {
        int cont = listanuevadespachos.length + i;
        _list.add(
          "${listaenproceso[i]["tram"]}/${listaenproceso[i]["codAduana"]}/${listaenproceso[i]["nroC"]}/${listaenproceso[i]["docEmb"]}",
        );
        searchListNumerator.add(cont);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    contextoPrncipal = context;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          key: key,
          appBar: buildBar(context),
          drawer: Drawer(
            width: 250,
            child: HomeDrawer(),
          ),
          body: TabBarView(children: <Widget>[
            Theme(
                data: HotelAppTheme.buildLightTheme(),
                child: Container(
                    child: Scaffold(
                        body: Stack(children: <Widget>[
                  InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(children: <Widget>[
                        //getAppBarUI(),
                        getSearchBarUI(),
                        isSearching == true
                            ? Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                  ),
                                  CircularProgressIndicator(
                                    color: greenColor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Cargando tramites...",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic),
                                  )
                                ],
                              )
                            : Expanded(
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    color: HotelAppTheme.buildLightTheme()
                                        .backgroundColor,
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
                      ]))
                ])))),
            Theme(
                data: HotelAppTheme.buildLightTheme(),
                child: Container(
                    child: Scaffold(
                        body: Stack(children: <Widget>[
                  InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(children: <Widget>[
                        //getAppBarUI(),
                        getSearchBarUI(),
                        Expanded(
                            child: NestedScrollView(
                                controller: _scrollController,
                                headerSliverBuilder: (BuildContext context,
                                    bool innerBoxIsScrolled) {
                                  return <Widget>[
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: <Widget>[],
                                        );
                                      }, childCount: 1),
                                    ),
                                  ];
                                },
                                body: isSearching == false
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        color: HotelAppTheme.buildLightTheme()
                                            .backgroundColor,
                                        child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(
                                            color: Colors.black,
                                          ),
                                          itemCount: 0,
                                          padding:
                                              const EdgeInsets.only(top: 0),
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
                                                                searchListNumerator[
                                                                    i]])));
                                                Navigator.push(context, route);
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${listanuevadespachos[i]["tram"]} | ${listanuevadespachos[i]["codAduana"]} | ${listanuevadespachos[i]["nroC"]} | ${listanuevadespachos[i]["codPatron"]}",
                                                  style: const TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.start,
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
                                                      "${listanuevadespachos[i]["razonSocial"]}",
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
                                      )
                                    : Container(
                                        color: HotelAppTheme.buildLightTheme()
                                            .backgroundColor,
                                        child: ListView.builder(
                                            itemCount: 0,
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    Column(children: [
                                                      SizedBox(
                                                          height:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  10,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.1,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: 0,
                                                                  itemBuilder: (context,
                                                                          i) =>
                                                                      Column(
                                                                          children: [
                                                                            SizedBox(height: 10),
                                                                            Center(
                                                                              child: Container(
                                                                                padding: const EdgeInsets.all(defaultPadding),
                                                                                decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                ),
                                                                                width: MediaQuery.of(context).size.width / 1.05,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Text(
                                                                                      "${listanuevadespachos[searchListNumerator[i]]["tram"]} | ${listanuevadespachos[searchListNumerator[i]]["codAduana"]} | ${listanuevadespachos[searchListNumerator[i]]["nroC"]} | ${listanuevadespachos[searchListNumerator[i]]["codPatron"]}",
                                                                                      style: const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(height: defaultPadding),
                                                                                    DespachoInfoCard(
                                                                                      svgSrc: "assets/icons/circulo.svg",
                                                                                      title: "${listanuevadespachos[searchListNumerator[i]]["razonSocial"]}",
                                                                                      amountOfFiles: "",
                                                                                      numOfFiles: "",
                                                                                    ),
                                                                                    DespachoInfoCard(
                                                                                      svgSrc: "assets/icons/circulo.svg",
                                                                                      title: "F.COM: ${listanuevadespachos[searchListNumerator[i]]["fCom"]}",
                                                                                      amountOfFiles: "",
                                                                                      numOfFiles: "",
                                                                                    ),
                                                                                    DespachoInfoCard(
                                                                                      svgSrc: "assets/icons/circulo.svg",
                                                                                      title: "PROVEEDOR: ${listanuevadespachos[searchListNumerator[i]]["prov"]}",
                                                                                      amountOfFiles: "",
                                                                                      numOfFiles: "",
                                                                                    ),
                                                                                    DespachoInfoCard(
                                                                                      svgSrc: "assets/icons/circulo.svg",
                                                                                      title: "ESTADO:",
                                                                                      amountOfFiles: "${listanuevadespachos[searchListNumerator[i]]["estado"]}",
                                                                                      numOfFiles: "",
                                                                                    ),
                                                                                    const SizedBox(height: 25),
                                                                                    SizedBox(
                                                                                        height: 45,
                                                                                        width: MediaQuery.of(context).size.width / 1.2,
                                                                                        child: RaisedButton(
                                                                                          onPressed: () {
                                                                                            final route = MaterialPageRoute(builder: ((context) => UnDespachoDetails(listanuevadespachos[searchListNumerator[i]])));
                                                                                            Navigator.push(context, route);
                                                                                          },
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                                                          padding: const EdgeInsets.all(3.0),
                                                                                          child: Ink(
                                                                                            decoration: const BoxDecoration(
                                                                                              gradient: LinearGradient(
                                                                                                colors: <Color>[
                                                                                                  Color.fromARGB(255, 38, 47, 119),
                                                                                                  Color.fromARGB(200, 25, 150, 211)
                                                                                                ],
                                                                                              ),
                                                                                              borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                                                                            ),
                                                                                            child: Container(
                                                                                              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                                                                              alignment: Alignment.center,
                                                                                              child: const Text(
                                                                                                "Mas detalles",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ])))
                                                    ]))))),
                      ]))
                ]))))
          ]),
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
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(Duration(milliseconds: 400));
                  setState(() {
                    isSearching = true;
                  });
                  
                  String tipodeestado = "0";
                  switch (nroDespacho) {
                    case "-1":
                      {
                        tipodeestado = "En proceso";
                      }
                      break;

                    case "-2":
                      {
                        //statements;
                        tipodeestado = "Validado";
                      }
                      break;
                    case "-3":
                      {
                        tipodeestado = "Tributo pagado";
                      }
                      break;
                    case "-4":
                      {
                        tipodeestado = "Retirada";
                      }
                      break;
                    case "-5":
                      {
                        //statements;
                        tipodeestado = "Facturado";
                      }
                      break;
                    default:
                      {
                        //statements;
                      }
                      break;
                  }
                  print("$url/busquedaGral?estado=$tipodeestado&texto=$searchText&idcliente=${userbody["IdCliente"]}");
                  var response = await http.get(
                      Uri.parse(
                          "$url/busquedaGral?estado=$tipodeestado&texto=$searchText&idcliente=${userbody["IdCliente"]}"),
                      headers: {
                        "Authorization": "Bearer " + tokenApi.toString()
                      });
                      setState(() {
                        listanuevadespachos = jsonDecode(response.body);
                        print(listanuevadespachos);
                        isSearching = false;
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

  void buildSearchList() {
    if (searchText.isEmpty) {
    } else {
      searchListNumerator = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(searchText.toLowerCase())) {
          searchListNumerator.add(i);
          print(i);
        }
      }
      setState(() {
        searchListNumerator;
      });
    }
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 80,
        centerTitle: true,
        bottom: TabBar(tabs: <Widget>[
          Tab(
            child: Text("Individual"),
          ),
          Tab(
            child: Text("Bloque"),
          ),
        ]),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 12,
            ),
            Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color:
                            Color.fromARGB(255, 46, 112, 156).withOpacity(0.6),
                        offset: const Offset(2.0, 4.0),
                        blurRadius: 40),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                  child: Image.asset(
                    logoSecundario,
                    color: white,
                  ),
                )),
          ],
        ));
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
}
