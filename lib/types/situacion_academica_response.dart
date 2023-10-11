class SituacionAcademicaResponse {
  String? mensajeRespuesta;
  Data? data;
  String? error;

  SituacionAcademicaResponse({this.mensajeRespuesta, this.data, this.error});

  SituacionAcademicaResponse.fromJson(Map<String, dynamic> json) {
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
  List<Planes>? planes;

  Data({this.planes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['planes'] != null) {
      planes = <Planes>[];
      json['planes'].forEach((v) {
        planes!.add(Planes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (planes != null) {
      data['planes'] = planes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Planes {
  String? clasePlan;
  String? tipoCarrera;
  String? codigoPlan;
  String? nombreCarrera;
  String? jornada;
  String? matriculado;
  String? estadoAcademico;
  String? semestreAnioInicio;
  String? semestrePeriodoInicio;
  String? semestreAnioFin;
  String? semestrePeriodoFin;
  String? ayear;
  String? perid;
  String? tipo;
  bool? vigente;
  bool? flagTituloTecnico;
  bool? flagStatus9550;
  bool? flagProcuraduria;
  List<Directorio>? directorio;
  PdfResponse? pdfResponse;

  Planes(
      {this.clasePlan,
      this.tipoCarrera,
      this.codigoPlan,
      this.nombreCarrera,
      this.jornada,
      this.matriculado,
      this.estadoAcademico,
      this.semestreAnioInicio,
      this.semestrePeriodoInicio,
      this.semestreAnioFin,
      this.semestrePeriodoFin,
      this.ayear,
      this.perid,
      this.tipo,
      this.vigente,
      this.flagTituloTecnico,
      this.flagStatus9550,
      this.flagProcuraduria,
      this.directorio,
      this.pdfResponse});

  Planes.fromJson(Map<String, dynamic> json) {
    clasePlan = json['clasePlan'];
    tipoCarrera = json['tipoCarrera'];
    codigoPlan = json['codigoPlan'];
    nombreCarrera = json['nombreCarrera'];
    jornada = json['jornada'];
    matriculado = json['matriculado'];
    estadoAcademico = json['estadoAcademico'];
    semestreAnioInicio = json['semestreAnioInicio'];
    semestrePeriodoInicio = json['semestrePeriodoInicio'];
    semestreAnioFin = json['semestreAnioFin'];
    semestrePeriodoFin = json['semestrePeriodoFin'];
    ayear = json['ayear'];
    perid = json['perid'];
    tipo = json['tipo'];
    vigente = json['vigente'];
    flagTituloTecnico = json['flagTituloTecnico'];
    flagStatus9550 = json['flagStatus9550'];
    flagProcuraduria = json['flagProcuraduria'];
    if (json['directorio'] != null) {
      directorio = <Directorio>[];
      json['directorio'].forEach((v) {
        directorio!.add(Directorio.fromJson(v));
      });
    }
    pdfResponse = json['pdfResponse'] != null
        ? PdfResponse.fromJson(json['pdfResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clasePlan'] = clasePlan;
    data['tipoCarrera'] = tipoCarrera;
    data['codigoPlan'] = codigoPlan;
    data['nombreCarrera'] = nombreCarrera;
    data['jornada'] = jornada;
    data['matriculado'] = matriculado;
    data['estadoAcademico'] = estadoAcademico;
    data['semestreAnioInicio'] = semestreAnioInicio;
    data['semestrePeriodoInicio'] = semestrePeriodoInicio;
    data['semestreAnioFin'] = semestreAnioFin;
    data['semestrePeriodoFin'] = semestrePeriodoFin;
    data['ayear'] = ayear;
    data['perid'] = perid;
    data['tipo'] = tipo;
    data['vigente'] = vigente;
    data['flagTituloTecnico'] = flagTituloTecnico;
    data['flagStatus9550'] = flagStatus9550;
    data['flagProcuraduria'] = flagProcuraduria;
    if (directorio != null) {
      data['directorio'] = directorio!.map((v) => v.toJson()).toList();
    }
    if (pdfResponse != null) {
      data['pdfResponse'] = pdfResponse!.toJson();
    }
    return data;
  }
}

class Directorio {
  String? nombre;
  String? cargo;
  String? email;
  String? direccion;
  String? fono;

  Directorio({this.nombre, this.cargo, this.email, this.direccion, this.fono});

  Directorio.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    cargo = json['cargo'];
    email = json['email'];
    direccion = json['direccion'];
    fono = json['fono'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['cargo'] = cargo;
    data['email'] = email;
    data['direccion'] = direccion;
    data['fono'] = fono;
    return data;
  }
}

class PdfResponse {
  String? folleto;
  String? pdf;

  PdfResponse({this.folleto, this.pdf});

  PdfResponse.fromJson(Map<String, dynamic> json) {
    folleto = json['folleto'];
    pdf = json['pdf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['folleto'] = folleto;
    data['pdf'] = pdf;
    return data;
  }
}