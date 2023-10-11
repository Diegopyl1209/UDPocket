import 'package:udpocket/types/horario_response.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

class HorarioUtils {
  static Future<HorarioResponse> getHorario() async {
    var response =
        await udpApiRequest(UdpApiMethod.get, UdpApiPath.horarioAlumno);

    return HorarioResponse.fromJson(response.data);
  }
}
