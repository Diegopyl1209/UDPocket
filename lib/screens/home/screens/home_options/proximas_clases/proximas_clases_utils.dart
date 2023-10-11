import 'package:udpocket/types/proximas_clases_response.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

class ProximasClasesUtils {
  static bool claseYaPaso(ProximaClase clase) {
    //obtener la hora actual
    int horaActual = DateTime.now().hour;
    int minutoActual = DateTime.now().minute;
    //obtener la hora de termino de la clase
    int horaTermino = int.parse(clase.horaTermino!.split(":")[0]);
    int minutoTermino = int.parse(clase.horaTermino!.split(":")[1]);

    if (horaActual > horaTermino) {
      return true;
    } else if (horaActual == horaTermino) {
      if (minutoActual > minutoTermino) {
        return true;
      }
    }
    return false;
  }

  static Future<ProximasClasesResponse> getProximasClases() async {
    var response =
        await udpApiRequest(UdpApiMethod.get, UdpApiPath.proximasClases);

    return ProximasClasesResponse.fromJson(response.data);
  }
}
