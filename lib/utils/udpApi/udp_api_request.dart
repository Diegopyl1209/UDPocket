import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udpocket/consts/udp_api_consts.dart';
import 'package:http/http.dart' as http;

Future<UdpApiResponse> udpApiRequest(
    UdpApiMethod method, UdpApiPath path) async {
  var prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('udpToken');
  if (token == null) {
    throw NoAuthTokenFound();
  }

  String pathString = _getPathFromEnum(path);
  Map<String, String> headers = {
    "Authorization": "Bearer $token",
    "Ocp-Apim-Subscription-Key": ocpApimSubKey,
    "Content-Type": "application/json",
  };

  Uri uri = Uri.parse(udpApiBaseUrl + pathString);
  http.Response response;
  switch (method) {
    case UdpApiMethod.get:
      response = await http.get(uri, headers: headers);
      break;
    case UdpApiMethod.post:
      response = await http.post(uri, headers: headers);
      break;
    default:
      response = await http.get(uri, headers: headers);
  }

  return UdpApiResponse(response.statusCode, jsonDecode(response.body));
}

String _getPathFromEnum(UdpApiPath path) {
  switch (path) {
    case UdpApiPath.proximasClases:
      return 'proximas-clases';
    case UdpApiPath.infoAlumno:
      return 'alumno-info-unificado';
    case UdpApiPath.validaSesion:
      return 'validasesion';
    case UdpApiPath.situacionAcademica:
      return 'situacion-academica';
    case UdpApiPath.horarioAlumno:
      return 'horario-alumno/2023/2'; //TODO: get current year and semester
    case UdpApiPath.notasAlumno:
      return 'notas-alumno/filtro/0/0/0/Todo';
    case UdpApiPath.calendario:
      return '/calendario/prePost/1'; //TODO: averiguar que es prePost
    default:
      return '';
  }
}

enum UdpApiMethod {
  get,
  post,
}

enum UdpApiPath {
  proximasClases,
  infoAlumno,
  validaSesion,
  situacionAcademica,
  horarioAlumno,
  notasAlumno,
  calendario,
}

class UdpApiResponse {
  final int statusCode;
  final Map<String, dynamic> data;

  UdpApiResponse(this.statusCode, this.data);
}

class NoAuthTokenFound extends Error {
  final String message = 'No auth token found';

  @override
  String toString() {
    return message;
  }
}
