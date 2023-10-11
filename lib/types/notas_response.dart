import 'package:flutter/foundation.dart';

class NotasResponse {
  String? mensajeRespuesta;
  Data? data;
  String? error;

  NotasResponse({this.mensajeRespuesta, this.data, this.error});

  NotasResponse.fromJson(Map<String, dynamic> json) {
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
  List<NotasAlumno>? notasAlumno;

  Data({this.notasAlumno});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notasAlumno'] != null) {
      notasAlumno = <NotasAlumno>[];
      json['notasAlumno'].forEach((v) {
        notasAlumno!.add(NotasAlumno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notasAlumno != null) {
      data['notasAlumno'] = notasAlumno!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotasAlumno {
  String? anio;
  int? periodo;
  String? objidSm;
  String? codigoAsignatura;
  String? nombreAsignatura;
  String? codigoSeccion;
  String? nombreProfesor;
  String? notaFinal;
  String? estadoAcademico;
  List<String>? docentes;

  NotasAlumno(
      {this.anio,
      this.periodo,
      this.objidSm,
      this.codigoAsignatura,
      this.nombreAsignatura,
      this.codigoSeccion,
      this.nombreProfesor,
      this.notaFinal,
      this.estadoAcademico,
      this.docentes});

  NotasAlumno.fromJson(Map<String, dynamic> json) {
    anio = json['anio'];
    periodo = json['periodo'];
    objidSm = json['objidSm'];
    codigoAsignatura = json['codigoAsignatura'];
    nombreAsignatura = json['nombreAsignatura'];
    codigoSeccion = json['codigoSeccion'];
    nombreProfesor = json['nombreProfesor'];
    notaFinal = json['notaFinal'];
    estadoAcademico = json['estadoAcademico'];
    if (json['docentes'] != null) {
      docentes = <String>[];
      json['docentes'].forEach((v) {
        docentes!.add(v.toString());
      });
    }
  }

  @override
  int get hashCode {
    return anio.hashCode ^
        periodo.hashCode ^
        objidSm.hashCode ^
        codigoAsignatura.hashCode ^
        nombreAsignatura.hashCode ^
        codigoSeccion.hashCode ^
        nombreProfesor.hashCode ^
        notaFinal.hashCode ^
        estadoAcademico.hashCode ^
        docentes.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotasAlumno &&
        other.anio == anio &&
        other.periodo == periodo &&
        other.objidSm == objidSm &&
        other.codigoAsignatura == codigoAsignatura &&
        other.nombreAsignatura == nombreAsignatura &&
        other.codigoSeccion == codigoSeccion &&
        other.nombreProfesor == nombreProfesor &&
        other.notaFinal == notaFinal &&
        other.estadoAcademico == estadoAcademico &&
        listEquals(other.docentes, docentes);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['anio'] = anio;
    data['periodo'] = periodo;
    data['objidSm'] = objidSm;
    data['codigoAsignatura'] = codigoAsignatura;
    data['nombreAsignatura'] = nombreAsignatura;
    data['codigoSeccion'] = codigoSeccion;
    data['nombreProfesor'] = nombreProfesor;
    data['notaFinal'] = notaFinal;
    data['estadoAcademico'] = estadoAcademico;
    if (docentes != null) {
      data['docentes'] = docentes!.map((v) => v.toString()).toList();
    }
    return data;
  }
}
