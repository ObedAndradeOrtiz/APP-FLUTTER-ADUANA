import 'package:flutter/material.dart';

class NewsPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body:
          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("EN DESARROLLO,  ¡MUY PRONTO!",style: TextStyle(color: Color.fromARGB(255, 16, 14, 121), fontWeight: FontWeight.bold, fontSize: 20),),
            Center(
          child: Image.asset("assets/images/desarrollo.png"),),
          SizedBox(width: MediaQuery.of(context).size.height/3, child:  Image.asset("assets/images/logoagora.png"),)]
        )));
      

  }
}
