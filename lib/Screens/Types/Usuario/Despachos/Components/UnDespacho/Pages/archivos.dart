// ignore_for_file: await_only_futures, non_constant_identifier_names

import 'dart:convert';
import 'package:app_universal/global/constants.dart';
import 'package:app_universal/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../widget/imagen.dart';
import '../../../../../../../widget/visordepdf.dart';
dynamic _milista;
bool cargando = false;
bool iniciar = false;
dynamic _archivos;
dynamic misarchivos;
class Myfiles extends StatefulWidget {
  Myfiles(dynamic archivos,dynamic _detalleDespacho, {Key? key}) : super(key: key) {
    _milista = archivos;
    misarchivos=_detalleDespacho;
  }

  @override
  State<Myfiles> createState() => _Myfiles();
}

///listaarchivos
class _Myfiles extends State<Myfiles> {
  static downloadingCallBack(id, status, progress) {


  }

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallBack);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Recibidos"),
              ),
              // Tab(
              //   child: Text("Enviados"),
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Recibidos(),
            //PageDespachoBotones(misarchivos),
          ],
        ),
      ),
    );
    // iniciar == true
    //           ? Container(
    //               //width: MediaQuery.of(context).size.width / 0.5,
    //               child: ListView.builder(
    //               itemCount: _milista.length,
    //               itemBuilder: (context, i) => Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Center(
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Icon(
    //                           Icons.file_copy_outlined,
    //                           color: primaryColor,
    //                           size: 25,
    //                         ),
    //                         Container(
    //                           //width: MediaQuery.of(context).size.width / 1.2,
    //                           child: TextButton(
    //                               onPressed: () {
    //                                 abrirImagen(i);
    //                               },
    //                               child: Text(_milista[i]["nombre"],
    //                                   maxLines: 5,
    //                                   style: TextStyle(
    //                                       color: Color.fromARGB(255, 1, 1, 1),
    //                                       fontSize: 13),
    //                                   textAlign: TextAlign.start)),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ))
    //           : Center();
  }

  Widget Recibidos() {
    return Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
                  // GFAccordion(
                  //         showAccordion: true,
                  //         collapsedTitleBackgroundColor:
                  //             const Color(0xFFE0E0E0),
                  //         title: "GESTOR",
                  //         contentChild: Column(children: [
                           
                  //               SizedBox(
                  //                       height: 140,
                  //                       child: ListView.builder(
                  //                           itemCount:_milista.length,
                                               
                  //                           itemBuilder: (context, index) =>
                  //                               Column(children: [
                  //                                 GestureDetector(
                  //                                   onTap: () {
                  //                                     abrirImagen(index);
                  //                                   },
                  //                                   child: Text(
                  //                                       _milista[index]["nombre"]),
                  //                                 ),
                  //                                 Divider(
                  //                                   color: blackColor,
                  //                                 )
                  //                               ])))
                                    
                  //         ])),
                         GFAccordion(
                          showAccordion: true,
                          collapsedTitleBackgroundColor:
                              const Color(0xFFE0E0E0),
                          title: "CLIENTE",
                          contentChild: Column(children: [
                                 SizedBox(height: 40,),
                                SizedBox(
                                        height: MediaQuery.of(context).size.height/1.8,
                                        child: ListView.builder(
                                            itemCount:listaarchivosCliente.length,
                                               
                                            itemBuilder: (context, index) =>
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      abrirDocuCliente(index);
                                                    },
                                                    child: Text(
                                                        listaarchivosCliente[index]["nombre"]),
                                                  ),
                                                  Divider(
                                                    color: blackColor,
                                                  )
                                                ])))
                                    
                          ])),
            // Padding(
            //   padding: const EdgeInsets.only(left: 18, top: 15),
            //   child: Row(
            //     children: [
            //       Text(
            //         'Archivos de mercaderia',
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //             color: primaryColor),
            //       ),
            //       IconButton(
            //           onPressed: () {},
            //           icon: Icon(
            //             Icons.info,
            //             color: primaryColor,
            //           ))
            //     ],
            //   ),
            // ),
            // ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: documetosList.length,
            //     itemBuilder: (context, i) => Column(children: [
                      
            //         ]))
          ])
          )
          );
    // return  Container(
    //         //width: MediaQuery.of(context).size.width / 0.5,
    //         child: ListView.builder(
    //         itemCount: _milista.length,
    //         itemBuilder: (context, i) => Column(
    //           children: [
    //             Center(
    //               child: Row(
    //                 children: [
    //                   Icon(
    //                     Icons.file_copy_outlined,
    //                     color: primaryColor,
    //                     size: 25,
    //                   ),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width / 1.2,
    //                     child: TextButton(
    //                         onPressed: () {
    //                           abrirImagen(i);
    //                         },
    //                         child: Text(_milista[i]["nombre"],
    //                             maxLines: 5,
    //                             style: TextStyle(
    //                                 color: Color.fromARGB(255, 1, 1, 1),
    //                                 fontSize: 13),
    //                             textAlign: TextAlign.start)),
    //                   ),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       ));
  }
 void abrirDocuCliente(int i) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      dynamic externalDir = await getExternalStorageDirectory();
      String cad=url +
              "/downloadarchivos?direccion=" +
               listaarchivosCliente[i]["direccion"] +
              "&name=" +
               "listaarchivosCliente[i]['nombre']" ;
      print(externalDir.path);
       irdownload(i,cad);
      // var pdf= await FlutterDownloader.enqueue(
      //     fileName:  listaarchivosCliente[i]["nombre"],
      //     url: url +
      //         "/downloadarchivos?direccion=" +
      //          listaarchivosCliente[i]["direccion"] +
      //         "&name=" +
      //          listaarchivosCliente[i]["nombre"],
      //     savedDir: externalDir.path,
      //     openFileFromNotification: true,
      //     showNotification: false,
      //     saveInPublicStorage: true).whenComplete.call(() => {
           
      //     }); 
    } else {}
    // print(
  }

  void irdownload(int i,String cad) async {
     if ( listaarchivosCliente[i]["nombre"].substring(
               listaarchivosCliente[i]["nombre"].length - 3,  listaarchivosCliente[i]["nombre"].length) ==
          "pdf" ) {
        
            final route = await MaterialPageRoute(
            builder: ((context) => Mypdf (cad, listaarchivosCliente[i]["nombre"],i
                // "/storage/emulated/0/Download/" +
                //      listaarchivosCliente[i]["nombre"],
                //  listaarchivosCliente[i]["nombre"]))
                 )));
        // ignore: use_build_context_synchronously
        Navigator.push(context, route); 
        
        
      } else {
           if( listaarchivosCliente[i]["nombre"].substring(
               listaarchivosCliente[i]["nombre"].length - 3,  listaarchivosCliente[i]["nombre"].length) ==
          "jpg"|| listaarchivosCliente[i]["nombre"].substring(
               listaarchivosCliente[i]["nombre"].length - 3,  listaarchivosCliente[i]["nombre"].length) ==
          "png" || listaarchivosCliente[i]["nombre"].substring(
               listaarchivosCliente[i]["nombre"].length - 3,  listaarchivosCliente[i]["nombre"].length) ==
          "jpeg" ){
         


        print(url +
            "/downloadarchivos?direccion=" +
             listaarchivosCliente[i]["direccion"] +
            "&name=" +
             listaarchivosCliente[i]["nombre"]);
        late Image imagen = Image.network(
          url +
              "/downloadarchivos?direccion=" +
               listaarchivosCliente[i]["direccion"] +
              "&name=" +
               listaarchivosCliente[i]["nombre"],
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
        final route = await MaterialPageRoute(
            builder: ((context) => MyImage(imagen, listaarchivosCliente[i])));
        Navigator.push(context, route);
      }
      else{
          
      }
    }
  }
  void abrirImagen(int i) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      dynamic externalDir = await getExternalStorageDirectory();
      print(externalDir.path);
      await FlutterDownloader.enqueue(
          fileName: _milista[i]["nombre"],
          url: url +
              "/downloadarchivos?direccion=" +
              _milista[i]["direccion"] +
              "&name=" +
              _milista[i]["nombre"],
          savedDir: externalDir.path,
          openFileFromNotification: true,
          showNotification: false,
          saveInPublicStorage: true);
      if (_milista[i]["nombre"].substring(
              _milista[i]["nombre"].length - 3, _milista[i]["nombre"].length) ==
          "pdf") {
        // final route = await MaterialPageRoute(
        //     builder: ((context) => PdfViewerPage(
        //         "/storage/emulated/0/Download/" +
        //             _milista[i]["nombre"],
        //         _milista[i]["nombre"])));
        // // ignore: use_build_context_synchronously
        // Navigator.push(context, route);
      } else {
        print(url +
            "/downloadarchivos?direccion=" +
            _milista[i]["direccion"] +
            "&name=" +
            _milista[i]["nombre"]);
        late Image imagen = Image.network(
          url +
              "/downloadarchivos?direccion=" +
              _milista[i]["direccion"] +
              "&name=" +
              _milista[i]["nombre"],
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
        final route = await MaterialPageRoute(
            builder: ((context) => MyImage(imagen, _milista[i])));
        Navigator.push(context, route);
      }
    } else {}
    // print(
  }

  void cagarLista() async {
    var responde = await http.get(
        Uri.parse("$url/listaarchivos?id=${_archivos["idSolicitud"]}"),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    if (_milista != null) {
      _milista = jsonDecode(responde.body);
      setState(() {
        iniciar = false;
      });
    }
  }
void cargarBotones()async{
         
  }
  Widget enviados() {
    return Center();
  }
}
