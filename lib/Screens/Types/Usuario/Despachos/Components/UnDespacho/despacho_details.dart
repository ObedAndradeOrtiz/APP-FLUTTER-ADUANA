import 'package:app_universal/Screens/Types/Usuario/Despachos/Components/UnDespacho/despacho_info_card.dart';
import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

import 'un_despacho_details.dart';

dynamic _detalleDespacho;

class DespachoDetails extends StatelessWidget {
  DespachoDetails(detallesDespacho, {Key? key}) : super(key: key) {
    _detalleDespacho = detallesDespacho;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2697FF),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            "${_detalleDespacho["tram"]}/${_detalleDespacho["codAduana"]}/${_detalleDespacho["nroC"]}/${_detalleDespacho["codPatron"]}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          DespachoInfoCard(
            svgSrc: "assets/icons/circulo.svg",
            title: "RAZON SOCIAL:",
            amountOfFiles: "",
            numOfFiles: "${_detalleDespacho["razonSocial"]}",
          ),
          DespachoInfoCard(
            svgSrc: "assets/icons/circulo.svg",
            title: "F.COM: ",
            amountOfFiles: "",
            numOfFiles: "${_detalleDespacho["fCom"]}",
          ),
          DespachoInfoCard(
            svgSrc: "assets/icons/circulo.svg",
            title: "PROVEEDOR: ",
            amountOfFiles: "",
            numOfFiles: "${_detalleDespacho["prov"]}",
          ),
          DespachoInfoCard(
            svgSrc: "assets/icons/circulo.svg",
            title: "MERCADERIA:",
            amountOfFiles: "",
            numOfFiles: "${_detalleDespacho["mERCADERIA"]}",
          ),
          DespachoInfoCard(
            svgSrc: "assets/icons/circulo.svg",
            title: "ESTADO:",
            amountOfFiles: "",
            numOfFiles: "${_detalleDespacho["estado"]}",
          ),
          const SizedBox(height: 25),
          SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.2,
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  final route = MaterialPageRoute(
                      builder: ((context) =>
                          UnDespachoDetails(_detalleDespacho)));
                  // ignore: use_build_context_synchronously
                  Navigator.push(context, route);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: const EdgeInsets.all(2.0),
                child: Ink(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: const Text(
                      "Mas detalles",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
