import 'dart:convert';

import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

String idSolicitud = "";
bool cargado = false;
dynamic detalles;

class PageDocumentos extends StatefulWidget {
  PageDocumentos(String idSoli, {super.key}) {
    idSolicitud = idSoli;
  }

  @override
  State<PageDocumentos> createState() => _PageDocumentosState();
}

class _PageDocumentosState extends State<PageDocumentos> {
  @override
  void initState() {
    cargarDocuemtos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return cargado == false
        ? Center()
        : Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
                   
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, i) => Column(children: [
                      GFAccordion(
                          showAccordion: true,
                          collapsedTitleBackgroundColor:
                              const Color(0xFFE0E0E0),
                          title: "DOCUMENTOS",
                          contentChild: Column(children: [
                            SizedBox(height: 25,),
                                Row(children: [SizedBox(width: 170,child: Text("Documento",maxLines: 3,),),                                        
                                             SizedBox(width: 80,child: Text("Nro. Doc",maxLines: 3,),),
                                              SizedBox(width: 70,child: Text("Estado",maxLines: 3,),)],),
                                              SizedBox(height: 25,),
                            SizedBox(
                                height: MediaQuery.of(context).size.height/2,
                                child: ListView.builder(
                                    itemCount: detalles.length,
                                    itemBuilder: (context, index) =>
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Row(children: [SizedBox(width: 170,child: Text(detalles[index]["documento"],maxLines: 3,),),
                                            
                                             SizedBox(width: 80,child: Text(detalles[index]["numeroDocumento"],maxLines: 3,),),
                                              SizedBox(width: 70,child: Text(detalles[index]["estado"],maxLines: 3,),)],) ,
                                              Divider(height: 15,)                                       
                                        ]))),
                          ])),

                    ])),
                     
          ])));
  }

  void cargarDocuemtos() async {
    var response = await http.get(
        Uri.parse("$url/documentos?id=" + idSolicitud.toString()),
        headers: {"Authorization": "Bearer " + tokenApi.toString()});
    if (response.body.length > 10) {
      setState(() {
        detalles = jsonDecode(response.body);
        cargado = true;
      });
    }
    print(response.body);
  }
}
