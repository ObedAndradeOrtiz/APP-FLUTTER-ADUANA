import 'package:app_universal/Models/usuario.dart';
import 'package:app_universal/Screens/Components/Chat/chat_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

//import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  bool touchUser = false;
  late IO.Socket socket;
  final usuarios = [
    Usuario(
        uid: '1',
        nombre: 'AGORA SOPORTE',
        email: 'agora.desarrollo.team@gmail.com',
        online: true,
        image: Image.asset("assets/images/iconoisotipo.png")),
    Usuario(
        uid: '2',
        nombre: 'ALTECBOL SOPORTE',
        email: 'altecbol.team@gmail.com',
        online: true,
        image: Image.asset("assets/images/altelbolicono.png")),
  ];
  @override
  void initState() {
    socket = IO.io(
        "http://181.115.152.194:3000",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'foo': 'bar'})
            .build());
    socket.connect();
    print("CONECTANDO AL SERVIDOR SOCKET");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _listViewUsuarios(),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => GestureDetector(
            onTap: () {
              setState(() {
                final route = MaterialPageRoute(
                    builder: ((context) => ChatPage(usuarios[i].nombre)));
                Navigator.push(context, route);
              });
            },
            child: _usuarioListTile(usuarios[i])),
        separatorBuilder: (_, i) => Divider(),
        itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: usuario.image == null
            ? Text(usuario.nombre.substring(0, 2))
            : usuario.image,
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  // _cargarUsuarios() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  // }
}
