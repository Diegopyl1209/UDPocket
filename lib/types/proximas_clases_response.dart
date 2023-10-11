class ProximasClasesResponse {
  String? mensajeRespuesta;
  List<ProximaClase>? data;
  String? error;

  ProximasClasesResponse({this.mensajeRespuesta, this.data, this.error});

  ProximasClasesResponse.fromJson(Map<String, dynamic> json) {
    mensajeRespuesta = json['mensajeRespuesta'];
    if (json['data'] != null) {
      data = <ProximaClase>[];
      json['data'].forEach((v) {
        data!.add(ProximaClase.fromJson(v));
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

class ProximaClase {
  String? sigla;
  String? asignatura;
  String? profesorNombre;
  String? profesorEmail;
  String? horarioDia;
  String? horaInicio;
  String? horaTermino;
  String? sala;
  String? edificio;
  String? direccion;
  int? piso;
  int? codigoSeccion;
  String? evento;
  String? eventoAbrev;

  ProximaClase(
      {this.sigla,
      this.asignatura,
      this.profesorNombre,
      this.profesorEmail,
      this.horarioDia,
      this.horaInicio,
      this.horaTermino,
      this.sala,
      this.edificio,
      this.direccion,
      this.piso,
      this.codigoSeccion,
      this.evento,
      this.eventoAbrev});

  ProximaClase.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
    asignatura = json['asignatura'];
    profesorNombre = json['profesorNombre'];
    profesorEmail = json['profesorEmail'];
    horarioDia = json['horarioDia'];
    horaInicio = json['horaInicio'];
    horaTermino = json['horaTermino'];
    sala = json['sala'];
    edificio = json['edificio'];
    direccion = json['direccion'];
    piso = json['piso'];
    codigoSeccion = json['codigoSeccion'];
    evento = json['evento'];
    eventoAbrev = json['eventoAbrev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sigla'] = sigla;
    data['asignatura'] = asignatura;
    data['profesorNombre'] = profesorNombre;
    data['profesorEmail'] = profesorEmail;
    data['horarioDia'] = horarioDia;
    data['horaInicio'] = horaInicio;
    data['horaTermino'] = horaTermino;
    data['sala'] = sala;
    data['edificio'] = edificio;
    data['direccion'] = direccion;
    data['piso'] = piso;
    data['codigoSeccion'] = codigoSeccion;
    data['evento'] = evento;
    data['eventoAbrev'] = eventoAbrev;
    return data;
  }
}
