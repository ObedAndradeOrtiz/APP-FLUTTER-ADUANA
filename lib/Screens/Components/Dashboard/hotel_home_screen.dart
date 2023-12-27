import 'dart:convert';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/despacho_screen.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/pages/busqueda.dart';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/dashboard_main.dart';
import 'package:app_universal/global/constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'hotel_app_theme.dart';
import 'hotel_list_view.dart';
import 'model/hotel_list_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

List<HotelListData> hotelList = [];

class HotelHomeScreen extends StatefulWidget {
  HotelHomeScreen();
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  bool touchUser = false;
  bool loading = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  dynamic listanuevadespachos = bodyJsonDespachos;
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
      searchListNumerator = [];
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(searchText.toLowerCase())) {
          searchListNumerator.add(i);
          print(i);
        }
      }
      setState(() {
        // ignore: unnecessary_statements
        searchListNumerator;
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
          "${bodyJsonDespachos[i]["tram"]}/${bodyJsonDespachos[i]["codAduana"]}/${bodyJsonDespachos[i]["nroC"]}/${bodyJsonDespachos[i]["docEmb"]}",
        );
      }
    }
  }

  // _cargarArchivos() async {
  //   var response = await http.get(
  //       Uri.parse(
  //           "$url/despachos?dato=${userbody["IdCargo"]}&id=${userbody["IdKardex"]}"),
  //       headers: {"Authorization": "Bearer " + tokenApi.toString()});
  //   print(response.body);
  //   setState(() {
  //     startDate = DateTime.now();
  //     endDate = DateTime.now().add(const Duration(days: 5));
  //     _list = [];
  //     searchListNumerator = [];
  //     auxsearchListNumerator = [];
  //     isSearching = false;
  //     searchText = "";
  //     print(userbody["IdCargo"]);
  //     bodyJsonDespachos = jsonDecode(response.body);
  //     listaDespachos = jsonDecode(response.body);
  //     listanuevadespachos = bodyJsonDespachos;
  //   });
  //   final route = MaterialPageRoute(
  //       builder: ((context) => MyHomePage(bodyJsonDespachos)));
  //   Navigator.push(context, route);
  //   await Future.delayed(Duration(milliseconds: 2000));
  //   //_refreshController.refreshCompleted();
  // }

  @override
  void initState() {
    EasyLoading.init();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    isSearching = false;
    init();
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
      floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                       //init();
                       recargar();
                    });
                  

                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(IconData(0xe0c1, fontFamily: 'MaterialIcons'),color: Colors.white,),
                ),
        body: loading == false
            ? Theme(
                data: HotelAppTheme.buildLightTheme(),
                child: Container(
                  child: Scaffold(
                    body: Stack(
                      children: <Widget>[
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // getAppBarUI(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, top: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      'Seguimiento de tramites',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: primaryColor),
                                    ),
                                    IconButton(
                                        onPressed: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'Seguimiento de tramites'),
                                                content: const Text(
                                                    'Los parametros de busqueda son los siguientes: \n\n 1.Cod. Aduana \n 2.Nro de Orden \n 3.Nro. C \n 4.Nro. de Tramite \n 5.Proveedor \n 6.Cod. de Patron \n\n Nota: Por favor respetar los espacios.'),
                                                actions: <Widget>[
                                                  
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'OK'),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        icon: Icon(
                                          Icons.info,
                                          color: primaryColor,
                                        ))
                                  ],
                                ),
                              ),
                              getSearchBarUI(),
                              FadeIn(
                                child: getListFiles(),
                                duration: Duration(seconds: 1),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ))
            : Scaffold(
                backgroundColor: white,
                body: SafeArea(
                    child: Center(
                  child: Container(
                      decoration: BoxDecoration(color: white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: FadeIn(
                              // ignore: sort_child_properties_last
                              child: Column(children: [
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height / 3,
                                // ),
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
                        ],
                      )),
                ))));
  }

  Widget getListFiles() {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
        elevation: 5,
        child: Column(
          children: <Widget>[
            //  GestureDetector(
            //  onTap: (){
            //   setState(() {
            //     pageIndex=1;
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(
            //       builder: (context) => MyHomePage(listaDespachos)));
            //   });
            //  },
            //  child:
            //  ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            //   title:  Row(children: [
            //     Text('Tareas'),
            //     Spacer(),
            //     Text("0"),
            //     Icon(
            //       Icons.navigate_next_rounded,
            //       color: primaryColor,
            //     )
            //   ]),
            //   leading: SizedBox(
            //     width: 30,
            //     child: Image.asset("assets/icons/hecho.png"),
            //   ),
            // )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 18, top: 12, bottom: 8),
        child: Row(
          children: [
            Text(
              'Lista de Tramites',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: primaryColor),
            ),
          ],
        ),
      ),
      GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            var response = await http.get(Uri.parse(

                    ///despachos?dato=-1&id=362
                    "$url/despachosCliente?dato=-1&id=${userbody["IdCliente"]}"),
                headers: {"Authorization": "Bearer " + tokenApi.toString()});
            listaenproceso = jsonDecode(response.body);
            setState(() {
              loading = false;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Despachos(listaenproceso, "-1")));
            });
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => Despachos(listaenproceso)));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Row(children: [
                    Text(listaestados[0]["estado"]),
                    Spacer(),
                    Text(cantidaddetramites[0]["enproceso"].toString()),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: primaryColor,
                    )
                  ]),
                  leading: Icon(
                    FontAwesomeIcons.fileCircleExclamation,
                    color: Color.fromARGB(195, 3, 195, 253),
                  ),
                ),
              ],
            ),
          )),
      GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            var response = await http.get(Uri.parse(

                    ///despachos?dato=-1&id=362
                    "$url/despachosCliente?dato=-2&id=${userbody["IdCliente"]}"),
                headers: {"Authorization": "Bearer " + tokenApi.toString()});
            listavalidado = jsonDecode(response.body);
            setState(() {
              loading = false;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Despachos(listavalidado, "-2")));
            });
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Row(children: [
                    Text(listaestados[1]["estado"]),
                    Spacer(),
                    Text(cantidaddetramites[0]["validado"].toString()),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: primaryColor,
                    )
                  ]),
                  leading: Icon(
                    FontAwesomeIcons.fileSignature,
                    color: Color.fromARGB(195, 253, 174, 3),
                  ),
                ),
              ],
            ),
          )),
      GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            var response = await http.get(Uri.parse(

                    ///despachos?dato=-1&id=362
                    "$url/despachosCliente?dato=-3&id=${userbody["IdCliente"]}"),
                headers: {"Authorization": "Bearer " + tokenApi.toString()});
            listapagado = jsonDecode(response.body);
            setState(() {
              loading = false;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Despachos(listapagado, "-3")));
            });
            //
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                  title: Row(children: [
                    Text(listaestados[2]["estado"]),
                    Spacer(),
                    Text(cantidaddetramites[0]["tributopagado"].toString()),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: primaryColor,
                    )
                  ]),
                  leading: Icon(
                    Icons.monetization_on,
                    color: Color.fromARGB(195, 124, 3, 253),
                  ),
                ),
              ],
            ),
          )),
      GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            var response = await http.get(Uri.parse(

                    ///despachos?dato=-1&id=362
                    "$url/despachosCliente?dato=-4&id=${userbody["IdCliente"]}"),
                headers: {"Authorization": "Bearer " + tokenApi.toString()});
            listaretirada = jsonDecode(response.body);
            setState(() {
              loading = false;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Despachos(listaretirada, "-4")));
            }); //
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Row(children: [
                      Text(listaestados[3]["estado"]),
                      Spacer(),
                      Text(cantidaddetramites[0]["retirada"].toString()),
                      Icon(
                        Icons.navigate_next_rounded,
                        color: primaryColor,
                      )
                    ]),
                    leading: Icon(
                      FontAwesomeIcons.fileExport,
                      color: Color.fromARGB(195, 253, 3, 3),
                    )),
              ],
            ),
          )),
      GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            var response = await http.get(Uri.parse(

                    ///despachos?dato=-1&id=362
                    "$url/despachosCliente?dato=-5&id=${userbody["IdCliente"]}"),
                headers: {"Authorization": "Bearer " + tokenApi.toString()});
            listafacturado = jsonDecode(response.body);
            setState(() {
              loading = false;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Despachos(listafacturado, "-5")));
            });
            //
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Row(children: [
                      Text(listaestados[4]["estado"]),
                      Spacer(),
                      Text(cantidaddetramites[0]["facturado"].toString()),
                      Icon(
                        Icons.navigate_next_rounded,
                        color: primaryColor,
                      )
                    ]),
                    leading: Icon(
                      FontAwesomeIcons.fileCircleCheck,
                      color:
                       Color.fromARGB(195, 3, 253, 11),
                    )),
              ],
            ),
          )),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            ),
          ],
        ),
      )
    ]);
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      // showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 0, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Bienvenido!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${userbody["Nombres"]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          // Text(
                          //   'Fecha',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 16,
                          //       color: Colors.grey.withOpacity(0.8)),
                          // ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // Text(
                          //   '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w100,
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Fecha actual',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // Text(
                          //   '${DateFormat("dd, MMM").format(startDate)}',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w100,
                          //     fontSize: 16,
                          //   ),
                          // ),
                          // Text(
                          //   'Number of Rooms',
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w100,
                          //       fontSize: 16,
                          //       color: Colors.grey.withOpacity(0.8)),
                          // ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // Text(
                          //   '1 Room - 2 Adults',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w100,
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      final route = MaterialPageRoute(
                          builder: ((context) => BusquedaScreen()));
                      Navigator.push(context, route);
                    },
                    // onChanged: (String txt) {
                    //   setState(() {
                    //     //_handleSearchStart();
                    //     searchText = txt;
                    //   });
                    //   // print(searchText);
                    //   // buildSearchList();
                    // },
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
                      final route = MaterialPageRoute(
                          builder: ((context) => BusquedaScreen()));
                      Navigator.push(context, route);
                  // FocusScope.of(context).unfocus();
                  // await Future.delayed(Duration(milliseconds: 400));
                  // setState(() {
                  //   isSearching = true;
                  // });

                  // String tipodeestado = "0";
                  // switch (nroDespacho) {
                  //   case "-1":
                  //     {
                  //       tipodeestado = "En proceso";
                  //     }
                  //     break;

                  //   case "-2":
                  //     {
                  //       //statements;
                  //       tipodeestado = "Validado";
                  //     }
                  //     break;
                  //   case "-3":
                  //     {
                  //       tipodeestado = "Tributo pagado";
                  //     }
                  //     break;
                  //   case "-4":
                  //     {
                  //       tipodeestado = "Retirada";
                  //     }
                  //     break;
                  //   case "-5":
                  //     {
                  //       //statements;
                  //       tipodeestado = "Facturado";
                  //     }
                  //     break;
                  //   default:
                  //     {
                  //       //statements;
                  //     }
                  //     break;
                  // }
                  // print("$url/busquedaGral?estado=${tipodeestado}&texto=${searchText}&idcliente=${userbody["IdCliente"]}");
                  // var response = await http.get(
                  //     Uri.parse(
                  //         "$url/busquedaGral?estado=${tipodeestado}&texto=${searchText}&idcliente=${userbody["IdCliente"]}"),
                  //     headers: {
                  //       "Authorization": "Bearer " + tokenApi.toString()
                  //     });
                  //     setState(() {
                  //       listanuevadespachos = jsonDecode(response.body);
                  //       print(listanuevadespachos);
                  //       isSearching = false;
                  //     });
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

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(
                //       '530 hotels found',
                //       style: TextStyle(
                //         fontWeight: FontWeight.w100,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     focusColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     hoverColor: Colors.transparent,
                //     splashColor: Colors.grey.withOpacity(0.2),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(4.0),
                //     ),
                //     onTap: () {
                //       FocusScope.of(context).requestFocus(FocusNode());
                //       Navigator.push<dynamic>(
                //         context,
                //         MaterialPageRoute<dynamic>(
                //             builder: (BuildContext context) => FiltersScreen(),
                //             fullscreenDialog: true),
                //       );
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8),
                //       child: Row(
                //         children: <Widget>[
                //           Text(
                //             'Filter',
                //             style: TextStyle(
                //               fontWeight: FontWeight.w100,
                //               fontSize: 16,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Icon(Icons.sort,
                //                 color: HotelAppTheme.buildLightTheme()
                //                     .primaryColor),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  // void showDemoDialog({BuildContext? context}) {
  //   showDialog<dynamic>(
  //     context: context!,
  //     builder: (BuildContext context) => CalendarPopupView(
  //       barrierDismissible: true,
  //       minimumDate: DateTime.now(),
  //       //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
  //       initialEndDate: endDate,
  //       initialStartDate: startDate,
  //       onApplyClick: (DateTime startData, DateTime endData) {
  //         setState(() {
  //           startDate = startData;
  //           endDate = endData;
  //         });
  //       },
  //       onCancelClick: () {},
  //     ),
  //   );
  // }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.locationDot),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void recargar() async{
  var response = await http.get(
            Uri.parse("$url/cantidaddespachos?id=${userbody["IdCliente"]}"),
            headers: {"Authorization": "Bearer " + tokenApi.toString()});
      setState(() {
         cantidaddetramites = jsonDecode(response.body);
      }); 
       Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MyHomePage(listaDespachos)));

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

// Expanded(
//   child: NestedScrollView(
//     controller: _scrollController,
//     headerSliverBuilder: (BuildContext context,
//         bool innerBoxIsScrolled) {
//       return <Widget>[
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//             return Column(
//               children: <Widget>[
//                 getSearchBarUI(),
//                 //getTimeDateUI()
//               ],
//             );
//           }, childCount: 1),
//         ),
//         SliverPersistentHeader(
//           pinned: true,
//           floating: true,
//           delegate: ContestTabHeader(
//             getFilterBarUI(),
//           ),
//         ),
//       ];
//     },
//     body: isSearching == false
//         ? Container(
//             color: HotelAppTheme.buildLightTheme()
//                 .backgroundColor,
//             child: ListView.builder(
//               itemCount: hotelList.length,
//               padding:
//                   const EdgeInsets.only(top: 0),
//               scrollDirection: Axis.vertical,
//               itemBuilder: (BuildContext context,
//                   int index) {
//                 final int count =
//                     hotelList.length > 10
//                         ? 10
//                         : hotelList.length;
//                 final Animation<
//                     double> animation = Tween<
//                             double>(
//                         begin: 0.0, end: 1.0)
//                     .animate(CurvedAnimation(
//                         parent:
//                             animationController!,
//                         curve: Interval(
//                             (1 / count) * index,
//                             1.0,
//                             curve: Curves
//                                 .fastOutSlowIn)));
//                 animationController?.forward();
//                 return HotelListView(
//                   callback: () {},
//                   hotelData: hotelList[index],
//                   animation: animation,
//                   animationController:
//                       animationController!,
//                 );
//               },
//             ),
//           )
//         : Container(
//             color: HotelAppTheme.buildLightTheme()
//                 .backgroundColor,
//             child: ListView.builder(
//                 itemCount:
//                     searchListNumerator.length,
//                 padding:
//                     const EdgeInsets.only(top: 0),
//                 scrollDirection: Axis.vertical,
//                 itemBuilder:
//                     (BuildContext context,
//                             int index) =>
//                         Column(children: [
//                           SizedBox(
//                               height: MediaQuery
//                                           .of(
//                                               context)
//                                       .size
//                                       .height /
//                                   1.3,
//                               width: MediaQuery.of(
//                                           context)
//                                       .size
//                                       .width /
//                                   1.1,
//                               child: ListView
//                                   .builder(
//                                       itemCount:
//                                           searchListNumerator
//                                               .length,
//                                       itemBuilder: (context,
//                                               i) =>
//                                           Column(
//                                               children: [
//                                                 SizedBox(height: 10),
//                                                 Center(
//                                                   child: Container(
//                                                     padding: const EdgeInsets.all(defaultPadding),
//                                                     decoration: const BoxDecoration(
//                                                       color: primaryColor,
//                                                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                                                     ),
//                                                     width: MediaQuery.of(context).size.width / 1.05,
//                                                     child: Column(
//                                                       children: [
//                                                         Text(
//                                                           "${listanuevadespachos[searchListNumerator[i]]["tram"]} | ${listanuevadespachos[searchListNumerator[i]]["codAduana"]} | ${listanuevadespachos[searchListNumerator[i]]["nroC"]} | ${listanuevadespachos[searchListNumerator[i]]["codPatron"]}",
//                                                           style: const TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 20,
//                                                             fontWeight: FontWeight.w500,
//                                                           ),
//                                                         ),
//                                                         const SizedBox(height: defaultPadding),
//                                                         DespachoInfoCard(
//                                                           svgSrc: "assets/icons/circulo.svg",
//                                                           title: "${listanuevadespachos[searchListNumerator[i]]["razonSocial"]}",
//                                                           amountOfFiles: "",
//                                                           numOfFiles: "",
//                                                         ),
//                                                         DespachoInfoCard(
//                                                           svgSrc: "assets/icons/circulo.svg",
//                                                           title: "F.COM: ${listanuevadespachos[searchListNumerator[i]]["fCom"]}",
//                                                           amountOfFiles: "",
//                                                           numOfFiles: "",
//                                                         ),
//                                                         DespachoInfoCard(
//                                                           svgSrc: "assets/icons/circulo.svg",
//                                                           title: "PROVEEDOR: ${listanuevadespachos[searchListNumerator[i]]["prov"]}",
//                                                           amountOfFiles: "",
//                                                           numOfFiles: "",
//                                                         ),
//                                                         DespachoInfoCard(
//                                                           svgSrc: "assets/icons/circulo.svg",
//                                                           title: "ESTADO:",
//                                                           amountOfFiles: "${listanuevadespachos[searchListNumerator[i]]["estado"]}",
//                                                           numOfFiles: "",
//                                                         ),
//                                                         const SizedBox(height: 25),
//                                                         SizedBox(
//                                                             height: 45,
//                                                             width: MediaQuery.of(context).size.width / 1.2,
//                                                             // ignore: deprecated_member_use
//                                                             child: RaisedButton(
//                                                               onPressed: () {
//                                                                 final route = MaterialPageRoute(builder: ((context) => UnDespachoDetails(listanuevadespachos[searchListNumerator[i]])));
//                                                                 Navigator.push(context, route);
//                                                               },
//                                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//                                                               padding: const EdgeInsets.all(3.0),
//                                                               child: Ink(
//                                                                 decoration: const BoxDecoration(
//                                                                   gradient: LinearGradient(
//                                                                     colors: <Color>[
//                                                                       Color.fromARGB(255, 38, 47, 119),
//                                                                       Color.fromARGB(200, 25, 150, 211)
//                                                                     ],
//                                                                   ),
//                                                                   borderRadius: BorderRadius.all(Radius.circular(80.0)),
//                                                                 ),
//                                                                 child: Container(
//                                                                   constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
//                                                                   alignment: Alignment.center,
//                                                                   child: const Text(
//                                                                     "Mas detalles",
//                                                                     textAlign: TextAlign.center,
//                                                                     style: TextStyle(color: Colors.white),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             )),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ])))
//                         ]))),
//   ),
