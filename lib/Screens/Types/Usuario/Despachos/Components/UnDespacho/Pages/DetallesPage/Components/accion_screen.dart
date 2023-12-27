import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

class Accion extends StatefulWidget {
  Accion({super.key});

  @override
  State<Accion> createState() => _AccionState();
}

class _AccionState extends State<Accion> {
List<String> acciones=["RETIRO DE MERCADERIA","NOTIFICACION","CONF. DE PAGO","SOLICITUD DE GASTO"];
String seleccionado="Seleccione opcion";
  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 25,
            ),
            DropdownButton(

              elevation: 15,
              hint: Text(seleccionado),
              items:acciones.map((String a){
              return DropdownMenuItem(
                value: a,
                child: Text(a));
            }).toList() , onChanged: ((value) {
              setState(() {
                seleccionado=value.toString();
              });
            })),
            SizedBox(height: 45,),
            Text("Descripcion:",style: TextStyle(color: primaryColor),),
            TextField(
              
            ),
            SizedBox(height: 45,),
            Text("Cargar imagen(es):",style: TextStyle(color: primaryColor),),
    ]);
  }
}