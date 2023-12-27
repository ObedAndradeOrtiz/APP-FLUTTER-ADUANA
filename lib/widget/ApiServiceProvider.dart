import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiServiceProvider {
  static const String BASE_URL =
      "http://181.115.152.194:5001/downloadarchivos?direccion=\\wsapl01\DatosSistema\DATAGORA\REGISTRO_CLIENTES\0\DESPACHOS\LA NACIONAL - WHITE BR621301085.pdf";

  static Future<String> loadPDF() async {
    var response = await http.get(Uri.parse(BASE_URL));

    var dir = await getExternalStorageDirectory();
    File file = new File("${dir?.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
