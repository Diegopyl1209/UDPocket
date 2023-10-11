class HorarioResponse {
  String? mensajeRespuesta;
  Data? data;
  String? error;

  HorarioResponse({this.mensajeRespuesta, this.data, this.error});

  HorarioResponse.fromJson(Map<String, dynamic> json) {
    mensajeRespuesta = json['mensajeRespuesta'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mensajeRespuesta'] = mensajeRespuesta;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  List<HorarioAlumno>? horarioAlumno;

  Data({this.horarioAlumno});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['horarioAlumno'] != null) {
      horarioAlumno = <HorarioAlumno>[];
      json['horarioAlumno'].forEach((v) {
        horarioAlumno!.add(HorarioAlumno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (horarioAlumno != null) {
      data['horarioAlumno'] = horarioAlumno!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HorarioAlumno {
  String? nombreD;
  List<Info>? info;
  bool? show;

  HorarioAlumno({this.nombreD, this.info, this.show});

  HorarioAlumno.fromJson(Map<String, dynamic> json) {
    nombreD = json['nombreD'];
    if (json['info'] != null) {
      info = <Info>[];
      json['info'].forEach((v) {
        info!.add(Info.fromJson(v));
      });
    }
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombreD'] = nombreD;
    if (info != null) {
      data['info'] = info!.map((v) => v.toJson()).toList();
    }
    data['show'] = show;
    return data;
  }
}

class Info {
  String? dia;
  String? asignatura;
  String? codigoSeccion;
  String? nombreAsig;
  String? horaInicio;
  String? horaTermino;
  String? sala;
  int? piso;
  String? evento;
  String? direccion;

  Info(
      {this.dia,
      this.asignatura,
      this.codigoSeccion,
      this.nombreAsig,
      this.horaInicio,
      this.horaTermino,
      this.sala,
      this.piso,
      this.evento,
      this.direccion});

  Info.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    asignatura = json['asignatura'];
    codigoSeccion = json['codigoSeccion'];
    nombreAsig = json['nombreAsig'];
    horaInicio = json['horaInicio'];
    horaTermino = json['horaTermino'];
    sala = json['sala'];
    piso = json['piso'];
    evento = json['evento'];
    direccion = json['direccion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dia'] = dia;
    data['asignatura'] = asignatura;
    data['codigoSeccion'] = codigoSeccion;
    data['nombreAsig'] = nombreAsig;
    data['horaInicio'] = horaInicio;
    data['horaTermino'] = horaTermino;
    data['sala'] = sala;
    data['piso'] = piso;
    data['evento'] = evento;
    data['direccion'] = direccion;
    return data;
  }
}
