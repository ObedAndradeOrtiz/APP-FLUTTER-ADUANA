import 'dart:io';
import 'package:app_universal/Screens/Types/Usuario/MainDashboard/Components/search_body.dart';
import 'package:flutter/material.dart';
var lista = ["Perfil", "opciones", "Cerrar Sesion"];
var _listaDespachos;

class MyHomePage extends StatelessWidget {
  MyHomePage(listaDespachos, {Key? key}) : super(key: key) {
    _listaDespachos = listaDespachos;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 12,
                title: const Text('¿Desea salir de la aplicación?'),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      exit(0);
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
        child: SearchBody(_listaDespachos));
  }
}
