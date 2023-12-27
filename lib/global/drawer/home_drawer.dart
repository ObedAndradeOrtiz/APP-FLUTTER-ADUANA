import 'dart:io';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/dashboard_main.dart';
import 'package:app_universal/global/app_theme.dart';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> with TickerProviderStateMixin {
  List<DrawerList>? drawerList;
  AnimationController? animationController;
  bool multiple = true;
  AnimationController? iconAnimationController;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  List<DrawerList> listaPanel = <DrawerList>[
    DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Tramites en transito',
        icon: Icon(Icons.home),
        pantalla: MyHomePage(bodyJsonDespachos)),
    DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Pte. de retiro',
        isAssetsImage: true,
        imageName: 'assets/images/supportIcon.png',
        pantalla: MyHomePage(bodyJsonDespachos)),
  ];

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
          index: DrawerIndex.HOME,
          labelName: 'Menu Principal',
          icon: Icon(Icons.home),
          pantalla: MyHomePage(bodyJsonDespachos)),
      // DrawerList(
      //     index: DrawerIndex.FeedBack,
      //     labelName: 'Comentarios',
      //     icon: Icon(Icons.help),
      //     pantalla: HelpScreen(logogeneral)),
      // DrawerList(
      //     index: DrawerIndex.About,
      //     labelName: 'Sobre Nosotros',
      //     icon: Icon(Icons.info),
      //     pantalla: MyHomePage(bodyJsonDespachos)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                          color: white,
                          
                        ),
                      )),
                ],
              ),
            ),
          ),
          
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
           const SizedBox(
            height: 4,
          ),
          Text("CLIENTE: "+userbody["RazonSocial"],style: TextStyle(color: white,fontWeight: FontWeight.bold),),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Row(children: [Spacer(), Text("V-"+version,style: TextStyle(color: white),)],),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Desarrollado por Ágora',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  onTapped();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  void onTapped() {
    exit(0);
    // setState(() {
    //   logout = true;
    // });
    // final route =
    //     MaterialPageRoute(builder: ((context) => const LoginScreen()));
    // // ignore: use_build_context_synchronously
    // Navigator.pushReplacement(context, route); // Print to console.
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          print("HolaIconos");
          setState(() {
            final route =
                MaterialPageRoute(builder: ((context) => listData.pantalla));
            Navigator.push(context, route);
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: GestureDetector(
                  onTap: () {
                    print("HolaGesture");
                    // ignore: unnecessary_statements
                    listData.pantalla;
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 6.0,
                        height: 46.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      listData.isAssetsImage
                          ? Container(
                              width: 24,
                              height: 24,
                              child: Image.asset(listData.imageName,
                                  color: Colors.blue),
                            )
                          : Icon(listData.icon?.icon, color: Colors.blue),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      Text(
                        listData.labelName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
  //   widget.callBackIndex!(indexScreen);
  // }
}

enum DrawerIndex {
  HOME,
  Tramites,
  FeedBack,
  Help,
  Share,
  About,
  Invite,
  Testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
    required this.pantalla,
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
  Widget pantalla;
}

class DrawerListofList {
  DrawerListofList(
      {this.isAssetsImage = false,
      this.labelName = '',
      this.icon,
      this.index,
      this.imageName = '',
      required this.submenu});

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
  List<DrawerList> submenu;
}
