import 'package:udpocket/types/notas_response.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

class NotasUtils {
  static Future<NotasResponse> getNotas() async {
    var response =
        await udpApiRequest(UdpApiMethod.get, UdpApiPath.notasAlumno);
    return NotasResponse.fromJson(response.data);
  }
}
