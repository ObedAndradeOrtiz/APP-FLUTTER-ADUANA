import 'package:flutter/material.dart';
//usyanbaluniv
//Y4nb4l2022**univ
//Color.fromARGB(160, 66, 97, 238);
const primaryColor = Color.fromARGB(255, 36, 45, 84);
const secondaryColor = Color.fromARGB(218, 89, 151, 31);
const bgColor = Color(0xFF212332);
const creamColor = Color(0xFFFFFFFF);
const snowColor = Color(0xFFFFFAFA);
const defaultPadding = 16.0;
bool iniciosesion = false;
var bodyJsonDespachos;
 int pageIndex = 0;
bool enTransito = false;
var listaDespachos;
bool listadespacho = false;
bool logout = false;
var myIDuserAndroid;
String logogeneral = "assets/images/fondouniversal.jpg";
String logoSecundario="assets/images/logoUniversalCuadrado.png";
String token="";
String tokenApi="";
dynamic listaarchivosCliente;
const url ="http://181.115.152.194:5001"; 
String version="1.0.0";

dynamic userbody;
dynamic urlArchivos;
dynamic listaNotificaiones;
dynamic listaNotificaionesAux;
String numeroConst = "";
bool escribiendoLogin = false;
bool recargarPage = false;
dynamic contextoPrncipal;



//TRAMITES ESTADOS Y CANTIDAD
//CANTIDAD
dynamic cantidaddetramites;
//ESTADOS
dynamic listaestados;

//EN PROCESO
dynamic listaenproceso;
//VALIDADO
dynamic listavalidado;
//TRIBUTO PAGADO
dynamic listapagado;
//RETIRADA
dynamic listaretirada;
//FACTURADO
dynamic listafacturado;







