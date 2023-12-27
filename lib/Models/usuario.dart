import 'package:flutter/cupertino.dart';

class Usuario {
  bool online;
  String email;
  String nombre;
  String uid;
  Image? image;

  Usuario(
      {required this.online,
      required this.email,
      required this.nombre,
      required this.uid,
      this.image});
}
