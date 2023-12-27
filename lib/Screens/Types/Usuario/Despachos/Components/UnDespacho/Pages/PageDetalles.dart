// ignore_for_file: unused_element, unused_import

import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/DetallesPage/Components/accion_screen.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/PageNotificaciones.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/Pages/pagedocumentos.dart';
import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/despacho_info_card.dart';
import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

dynamic _detalleDespacho;
dynamic _botonesDespachos;
dynamic jsonBody;
dynamic _imagenesList;
List<dynamic> _imagenesListGeneral = [];
List<int> _numerosList = [];
bool hayImagen = false;
bool recargarBotones = false;

class PageDetalles extends StatefulWidget {
  PageDetalles(detallesDespacho, {super.key}) {
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
      recargarPage = false;
    }
  }

  @override
  State<PageDetalles> createState() => _PageDetallesState();
}

class _PageDetallesState extends State<PageDetalles> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text("Detalles"),
              ),
              // Tab(
              //   child: Text("Notificar"),
              // ),
              Tab(
                child: Text("Documentos"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            pageOne(context),
            // Center(
            //   child: Text("It's cloudy here"),
            // ),
           // PageNotificacion(_detalleDespacho),
            PageDocumentos(_detalleDespacho["idSolicitud"].toString()),
          ],
        ),
      ),
    );
  }
}

Widget pageOne(context) {
  return Column(children: [
    GFAccordion(
      showAccordion: true,
      collapsedTitleBackgroundColor: const Color(0xFFE0E0E0),
      title: 'Detalle de Despacho',
      contentChild: Column(children: [
        SizedBox(
          height: 15,
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title:
              "${_detalleDespacho["tram"]}/${_detalleDespacho["codAduana"]}/${_detalleDespacho["nroC"]}/${_detalleDespacho["codPatron"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "NRO. DE ORDEN: ${_detalleDespacho["nroSeguimiento"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "${_detalleDespacho["razonSocial"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "PROVEEDOR: ${_detalleDespacho["prov"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "CANAL: ${_detalleDespacho["canal"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "MERCADERIA: ${_detalleDespacho["mERCADERIA"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "F.COM: ${_detalleDespacho["fCom"]} ",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "DOC. EMB: ${_detalleDespacho["docEmb"]}",
          amountOfFiles: "",
          numOfFiles: "",
        ),
        DespachoInfoCard(
          svgSrc: "assets/icons/circulo.svg",
          title: "ESTADO:",
          amountOfFiles: "${_detalleDespacho["estado"]}",
          numOfFiles: "",
        )
      ]),
      collapsedIcon: Icon(Icons.arrow_drop_down),
      expandedIcon: Icon(Icons.arrow_drop_up),
    )
  ]);
}
