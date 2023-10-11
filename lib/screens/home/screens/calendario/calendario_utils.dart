import 'package:intl/intl.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

import '../../../../types/calendario_response.dart';

class CalendarioUtils {
  static Future<CalendarioResponse> getCalendario() async {
    var response = await udpApiRequest(UdpApiMethod.get, UdpApiPath.calendario);
    print("calendario getter");
    return CalendarioResponse.fromJson(response.data);
  }

  static String getNombreDia(DateTime fecha) {
    return DateFormat.EEEE('es').format(fecha);
  }

  static String getNombreDiaShort(DateTime fecha) {
    return DateFormat.E('es').format(fecha);
  }

  static String getNombreMes(DateTime fecha) {
    return DateFormat.MMMM('es').format(fecha);
  }

  //ej : lunes, 12 de enero
  static String getNombreDiaMes(DateTime fecha) {
    return "${getNombreDia(fecha)}, ${fecha.day} de ${getNombreMes(fecha)}";
  }

  static DateTime getFormatedFecha(EventoCalendario evento) {
    DateFormat format = DateFormat("dd-MM-yyyy HH:mm");
    return format.parse(evento.desde!);
  }

  static DateTime getFormatedFechaTermino(EventoCalendario evento) {
    DateFormat format = DateFormat("dd-MM-yyyy HH:mm");
    return format.parse(evento.hasta!);
  }
}
