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

  static Future<ProximasClasesData> getProximasClases() async {
    var response =
        await udpApiRequest(UdpApiMethod.get, UdpApiPath.proximasClases);
    bool error = false;
    bool empty = false;
    if (response.statusCode == 204) {
      empty = true;
      return ProximasClasesData(error: error, empty: empty);
    }
    ProximasClasesResponse parsedData;
    try {
      parsedData = ProximasClasesResponse.fromJson(response.data);
    }catch(e){
      error = true;
      return ProximasClasesData(error: error, empty: empty);
    }

    return ProximasClasesData(error: error, empty: empty, data: parsedData);
  }
}

class ProximasClasesData {
  bool error;
  bool empty;

  ProximasClasesResponse? data;

  ProximasClasesData({
    required this.error,
    required this.empty,
    this.data,
  });
}