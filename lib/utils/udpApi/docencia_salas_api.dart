import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:udpocket/types/salas_docencia_response.dart';

const String salasDocenciaUrl = 'https://api-salas.docencia.io/';

Future<SalasDocenciaResponse> getSalasDocencia() async {
  print("getSalasDocencia");

  http.Response response = await http.get(Uri.parse(salasDocenciaUrl));
  return SalasDocenciaResponse.fromJson(jsonDecode(response.body));
}