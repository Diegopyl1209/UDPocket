import 'package:flutter/material.dart';
import 'package:udpocket/types/info_alumno_response.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

class PerfilPageProvider with ChangeNotifier {
  static final Future<InfoAlumnoResponse> infoAlumno = getInfoAlumnoResponse();

  Future<InfoAlumnoResponse> get getInfoAlumno => infoAlumno;

  static Future<InfoAlumnoResponse> getInfoAlumnoResponse() async {
    print("getInfoAlumno");
    var response = await udpApiRequest(UdpApiMethod.get, UdpApiPath.infoAlumno);
    return InfoAlumnoResponse.fromJson(response.data);
  }
}
