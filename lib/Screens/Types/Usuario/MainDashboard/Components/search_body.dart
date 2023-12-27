// ignore_for_file: unused_element, unused_field, deprecated_member_use
import 'package:app_universal/Screens/Components/Dashboard/hotel_home_screen.dart';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/Pages/page_news.dart';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/Pages/page_notify.dart';
import 'package:app_universal/Screens/Types/Usuario/Perfil/home_page_profile.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/drawer/home_drawer.dart';
import 'package:app_universal/global/theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// String _textoCard = "";
// String _textCardSub = "";
dynamic _listaDespachos = bodyJsonDespachos;

class SearchBody extends StatefulWidget {
  SearchBody(listaDespachos, {Key? key}) : super(key: key) {
    _listaDespachos = bodyJsonDespachos;
  }

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchBody> {
  dynamic listanuevadespachos = bodyJsonDespachos;
  List<String> _list = [];
  List<int> searchListNumerator = [];
  List<int> auxsearchListNumerator = [];
  bool isSearching = false;
  String searchText = "";
  bool bucadorSecundario = false;
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void irPerfil() {
      final route =
          MaterialPageRoute(builder: ((context) => HomePageProfile()));
      Navigator.push(context, route);
    }

    return Scaffold(
        key: key,
        appBar: buildBar(context),
        drawer: Drawer(
          width: 300,
          child: HomeDrawer(),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageIndex,
          height: 60.0,
          items: <Widget>[
            SvgPicture.asset(
              "assets/icons/menu_dashbord.svg",
              color: Colors.white,
              width: 35,
              height: 35,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Icon(
                Icons.chat_sharp,

                size: 30,
                color: Colors.white,
              ),
              Text("Chats",style: TextStyle(color: white, fontSize: 9),),
            ],),
          
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(
              Icons.notifications_active,
              size: 30,
              color: Colors.white,
            ),
            Text("Alertas",style: TextStyle(color: white, fontSize: 9),)
           ],),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //       Image.asset(
            //         "assets/images/supportIcon.png",
            //         color: Colors.white,
            //         width: 35,
            //       ),
            //       Text(
            //         "Soporte",
            //         style: TextStyle(color: Colors.white, fontSize: 9),
            //       ),
            //     ]),
          ],
          color: Color.fromARGB(255, 36, 45, 84),
          buttonBackgroundColor: Color.fromARGB(255, 75, 188, 253),
          backgroundColor: Color.fromARGB(218, 31, 53, 151),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 700),
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        // floatingActionButton: _pageIndex == 2
        //     ? FloatingActionButton(
        //         onPressed: () {
        //           openAlertBox();
        //         },
        //         backgroundColor: Color.fromARGB(255, 75, 188, 253),
        //         child: Column(children: [
        //           Image.asset(
        //             "assets/images/supportIcon.png",
        //             color: Colors.white,
        //             height: 35,
        //             width: 35,
        //           ),
        //           Text(
        //             "Soporte",
        //             style: TextStyle(color: Colors.white, fontSize: 10),
        //           ),
        //         ]),
        //       )
        //     : null,
        body:  
        _pageChooser(pageIndex));
  }

  Widget _pageChooser(int page) {
    switch (page) {
      
      case 0:
        {
          return HotelHomeScreen();
        }
      // case 0:
      //   {
      //     return Tasks();
      //   }

      case 1:
        {
          return NewsPaper();
        }

      case 2:
        {
          return NotifyPage();
        }
      // case 3:
      //   {
      //     return UsuariosPage();
      //   }
    }
    return Center();
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 80,
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
                
                  child: Image.asset(
                    logoSecundario,
                     color: white,
                  ),
                ),
               
              
               
          ],
        ));
  }
}

//  SizedBox(width: MediaQuery.of(context).size.width/10,child:  GestureDetector(
              //   onTap: (){

              //   },
              //     child:  Container(
              //   height: 50,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     boxShadow: <BoxShadow>[
              //       BoxShadow(
              //           color:
              //               Color.fromARGB(255, 75, 162, 219).withOpacity(0.6),
              //           offset: const Offset(2.0, 4.0),
              //           blurRadius: 40),
              //     ],
              //   ),
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              //     child: Column(children: [
              //      Image.asset(
              //       "assets/images/supportIcon.png",
              //       color: white,
              //     ),
              //     Text("Soporte",style: TextStyle(color: white,fontSize: 8),)
              //     ],)
                     
              //   )),
              //   ),),




Color myColor = Color(0xff00bfa5);


//   void opciones(context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: const EdgeInsets.all(15),
//             elevation: 16,
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   InkWell(
//                     splashColor: Color.fromARGB(255, 139, 50, 50),
//                     focusColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     onTap: () {
//                       final route = MaterialPageRoute(
//                           builder: ((context) => ChatPageAgora()));
//                       Navigator.push(context, route);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(25),
//                       decoration: const BoxDecoration(
//                           border: Border(
//                               bottom:
//                                   BorderSide(width: 1, color: primaryColor))),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Text("Soporte Ágora",
//                                   style: TextStyle(fontSize: 16))),
//                           Image.asset(
//                             "assets/images/iconoisotipo.png",
//                             scale: 5,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       final route = MaterialPageRoute(
//                           builder: ((context) => ChatPageAltelbol()));
//                       Navigator.push(context, route);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(25),
//                       decoration: const BoxDecoration(
//                           border: Border(
//                               bottom:
//                                   BorderSide(width: 1, color: primaryColor))),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Text("Soporte Altelbol",
//                                   style: TextStyle(fontSize: 16))),
//                           Image.asset(
//                             'assets/images/altelbolicono.png',
//                             width: 35,
//                             height: 35,
//                             fit: BoxFit.fill,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(25),
//                       decoration: const BoxDecoration(
//                           border: Border(
//                               bottom:
//                                   BorderSide(width: 1, color: Colors.white))),
//                       child: Row(
//                         children: const [
//                           Expanded(
//                               child: Text("Cancelar o Cerrar",
//                                   style: TextStyle(fontSize: 16))),
//                           Icon(
//                             Icons.cancel,
//                             color: Colors.red,
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }



  // openAlertBox() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //           contentPadding: EdgeInsets.only(top: 10.0),
  //           content: Container(
  //             width: 300.0,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Text(
  //                       "Contactar Soporte",
  //                       style: TextStyle(
  //                           fontSize: 24.0,
  //                           fontWeight: FontWeight.w700,
  //                           color: blueColor),
  //                     ),
  //                   ],
  //                 ),
  //                 Divider(
  //                   color: blueColor,
  //                   height: 5.0,
  //                 ),
  //                 InkWell(
  //                   child: Container(
  //                     padding: EdgeInsets.only(top: 5.0, bottom: 20.0),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.only(
  //                           bottomLeft: Radius.circular(20.0),
  //                           bottomRight: Radius.circular(20.0)),
  //                     ),
  //                     child: Column(
  //                       children: [
  //                         InkWell(
  //                           splashColor: Color.fromARGB(255, 139, 50, 50),
  //                           focusColor: Colors.transparent,
  //                           highlightColor: Colors.transparent,
  //                           hoverColor: Colors.transparent,
  //                           onTap: () {
  //                             final route = MaterialPageRoute(
  //                                 builder: ((context) => HelpScreen(
  //                                     "assets/images/imgAgoraApp.png")));
  //                             Navigator.push(context, route);
  //                           },
  //                           child: Container(
  //                             padding: const EdgeInsets.all(10),
  //                             child: Row(
  //                               children: [
  //                                 Expanded(
  //                                     child: Text("Soporte Ágora",
  //                                         style: TextStyle(
  //                                             fontSize: 16, color: blueColor))),
  //                                 Image.asset(
  //                                   "assets/images/iconoisotipo.png",
  //                                   scale: 5,
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         InkWell(
  //                           onTap: () {
  //                             final route = MaterialPageRoute(
  //                                 builder: ((context) => HelpScreen(
  //                                     "assets/images/altelbolicono.png")));
  //                             Navigator.push(context, route);
  //                           },
  //                           child: Container(
  //                             padding: const EdgeInsets.all(10),
  //                             child: Row(
  //                               children: [
  //                                 Expanded(
  //                                     child: Text("Soporte Altelbol",
  //                                         style: TextStyle(
  //                                             fontSize: 16, color: blueColor))),
  //                                 Image.asset(
  //                                   'assets/images/altelbolicono.png',
  //                                   width: 35,
  //                                   height: 35,
  //                                   fit: BoxFit.fill,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         InkWell(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Container(
  //                             padding: const EdgeInsets.all(10),
  //                             child: Row(
  //                               children: const [
  //                                 Expanded(
  //                                     child: Text("Cancelar o Cerrar",
  //                                         style: TextStyle(
  //                                             fontSize: 16,
  //                                             color: Colors.blue))),
  //                                 Icon(
  //                                   Icons.cancel,
  //                                   color: Colors.red,
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }