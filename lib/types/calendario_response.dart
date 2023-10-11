class CalendarioResponse {
  String? mensajeRespuesta;
  List<EventoCalendario>? data;
  String? error;

  CalendarioResponse({this.mensajeRespuesta, this.data, this.error});

  CalendarioResponse.fromJson(Map<String, dynamic> json) {
    mensajeRespuesta = json['mensajeRespuesta'];
    if (json['data'] != null) {
      data = <EventoCalendario>[];
      json['data'].forEach((v) {
        data!.add(EventoCalendario.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mensajeRespuesta'] = mensajeRespuesta;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    return data;
  }
}

class EventoCalendario {
  String? titulo;
  String? descripcion;
  String? link;
  String? desde;
  String? hasta;
  String? grado;
  int? nivel;
  int? rut;
  String? dv;
  int? anio;

  EventoCalendario(
      {this.titulo,
      this.descripcion,
      this.link,
      this.desde,
      this.hasta,
      this.grado,
      this.nivel,
      this.rut,
      this.dv,
      this.anio});

  EventoCalendario.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    link = json['link'];
    desde = json['desde'];
    hasta = json['hasta'];
    grado = json['grado'];
    nivel = json['nivel'];
    rut = json['rut'];
    dv = json['dv'];
    anio = json['anio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['descripcion'] = descripcion;
    data['link'] = link;
    data['desde'] = desde;
    data['hasta'] = hasta;
    data['grado'] = grado;
    data['nivel'] = nivel;
    data['rut'] = rut;
    data['dv'] = dv;
    data['anio'] = anio;
    return data;
  }
}
