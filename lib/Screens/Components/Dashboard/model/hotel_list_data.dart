
import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
    required this.icon,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;
  Icon icon;

  static List<HotelListData> hotelList = userbody["IdCargo"] == "2"
      ? <HotelListData>[
          HotelListData(
              imagePath: 'assets/hotel/hotel_2.png',
              titleTxt: 'EN TRANSITO',
              subTxt: 'Tramites en transito',
              dist: 4.0,
              reviews: 74,
              rating: 4.5,
              perNight: 0,
              icon: Icon(
                FontAwesomeIcons.fileCircleExclamation,
                color: Color.fromARGB(195, 3, 195, 253),
              )
              //icon:fileCircleExclamation
              //color: Color.fromARGB(195, 253, 41, 3),
              ),
          HotelListData(
              imagePath: 'assets/hotel/hotel_1.png',
              titleTxt: 'PTE. DE RETIRO',
              subTxt: 'Tramitess pendientes de retiro',
              dist: 2.0,
              reviews: 80,
              rating: 4.4,
              perNight: listaDespachos.length,
              icon: Icon(
                FontAwesomeIcons.fileCircleCheck,
                color: Color.fromARGB(195, 3, 253, 11),
              )
              //icon:fileCircleCheck,
              //color:Color.fromARGB(195, 3, 253, 11)
              ),
          HotelListData(
              imagePath: 'assets/hotel/hotel_1.png',
              titleTxt: 'PTE. ENTREGA DE DOC',
              subTxt: 'Tramitess pendientes de retiro',
              dist: 2.0,
              reviews: 80,
              rating: 4.4,
              perNight: 0,
              icon: Icon(
                FontAwesomeIcons.fileCirclePlus,
                color: Color.fromARGB(195, 124, 3, 253),
              )
              //icon:fileCircleCheck,
              //color:Color.fromARGB(195, 3, 253, 11)
              ),
          HotelListData(
              imagePath: 'assets/hotel/hotel_1.png',
              titleTxt: 'PTE. DE REGULARIZAR',
              subTxt: 'Tramitess pendientes de retiro',
              dist: 2.0,
              reviews: 80,
              rating: 4.4,
              perNight: 0,
              icon: Icon(
                FontAwesomeIcons.fileCircleQuestion,
                color: Color.fromARGB(195, 253, 195, 3),
              )
              //icon:fileCircleCheck,
              //color:Color.fromARGB(195, 3, 253, 11)
              ),
          HotelListData(
              imagePath: 'assets/hotel/hotel_1.png',
              titleTxt: 'VENCIMIENTOS',
              subTxt: 'Tramitess pendientes de retiro',
              dist: 2.0,
              reviews: 80,
              rating: 4.4,
              perNight: 0,
              icon: Icon(
                FontAwesomeIcons.fileCircleXmark,
                color: Color.fromARGB(195, 253, 3, 3),
              )
              //icon:fileCircleCheck,
              //color:Color.fromARGB(195, 3, 253, 11)
              ),
        ]
      : userbody["IdCargo"] == "8"
          ? <HotelListData>[
              HotelListData(
                  imagePath: 'assets/hotel/hotel_1.png',
                  titleTxt: 'PTE. DE RETIRO',
                  subTxt: 'Tramitess pendientes de retiro',
                  dist: 2.0,
                  reviews: 80,
                  rating: 4.4,
                  perNight: listaDespachos.length,
                  icon: Icon(
                    FontAwesomeIcons.fileCircleCheck,
                    color: Color.fromARGB(195, 3, 253, 11),
                  )
                  //icon:fileCircleCheck,
                  //color:Color.fromARGB(195, 3, 253, 11)
                  ),

              //icon:fileCircleCheck,
              //color:Color.fromARGB(195, 3, 253, 11)
            ]
          : <HotelListData>[
              HotelListData(
                  imagePath: 'assets/hotel/hotel_1.png',
                  titleTxt: 'SIN INFORMACION',
                  subTxt: 'No existen datos',
                  dist: 2.0,
                  reviews: 80,
                  rating: 4.4,
                  perNight: listaDespachos.length,
                  icon: Icon(
                    FontAwesomeIcons.fileCircleXmark,
                    color: Color.fromARGB(195, 3, 253, 11),
                  )
                  //icon:fileCircleCheck,
                  //color:Color.fromARGB(195, 3, 253, 11)
                  ),
            ];

  void createList() {}
}
