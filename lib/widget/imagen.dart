// ignore_for_file: must_be_immutable

import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

dynamic imagen;
Image? imagenNet;
class MyImage extends StatefulWidget {
  bool cargando = false;
  MyImage(Image imageN, dynamic body) {
    imagenNet = imageN;
    imagen = body;
  }

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialApp(
      title: 'Vista de Imagen',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text(imagen["nombre"])),
            backgroundColor: primaryColor,
          ),
          body: Center(child: imagenNet)),
    ));
  }
}
