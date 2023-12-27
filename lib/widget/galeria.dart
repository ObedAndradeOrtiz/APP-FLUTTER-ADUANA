import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

import 'imagen.dart';

dynamic _milista;
bool cargando = false;

class MyGalery extends StatefulWidget {
  MyGalery(dynamic lista, {Key? key}) : super(key: key) {
    _milista = lista;
  }

  @override
  State<MyGalery> createState() => _MyGalery();
}

class _MyGalery extends State<MyGalery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Galeria de imagenes')),
            backgroundColor: primaryColor,
          ),
          body: Container(
              width: MediaQuery.of(context).size.width / 0.5,
              child: ListView.builder(
                itemCount: _milista.length,
                itemBuilder: (context, i) => Column(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Icon(
                            Icons.image,
                            color: primaryColor,
                            size: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextButton(
                                onPressed: () {
                                  abrirImagen(i);
                                },
                                child: Text(_milista[i]["nombre"],
                                    maxLines: 5,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 1, 1, 1),
                                        fontSize: 13))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    ));
  }

  void abrirImagen(int i) async {
    Image imagen = Image.network(
      url +
          "/dowloadimage?direccion=" +
          urlArchivos.toString() +
          _milista[i]["direccion"] +
          "\\" +
          "&name=" +
          _milista[i]["nombre"],
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    var route =
        MaterialPageRoute(builder: ((context) => MyImage(imagen, _milista[i])));
    Navigator.push(context, route);
  }
}
