class InfoAlumnoResponse {
  String? mensajeRespuesta;
  Data? data;
  String? error;

  InfoAlumnoResponse({this.mensajeRespuesta, this.data, this.error});

  InfoAlumnoResponse.fromJson(Map<String, dynamic> json) {
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
  String? rut;
  String? dv;
  String? nombre1;
  String? nombre2;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? sexo;
  String? fechaNacimiento;
  String? email;
  String? emailUdp;
  String? fono;
  String? celular;
  String? calle;
  String? numero;
  String? depto;
  String? ciudad;
  String? comuna;
  String? rutCompleto;
  String? nombreCompleto;
  String? numeroMatricula;
  int? regionId;
  int? comunaId;
  String? mailsocial;
  String? nombresocial;
  String? primerNombreSocial;
  String? homeImagen;

  Data(
      {this.rut,
      this.dv,
      this.nombre1,
      this.nombre2,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.sexo,
      this.fechaNacimiento,
      this.email,
      this.emailUdp,
      this.fono,
      this.celular,
      this.calle,
      this.numero,
      this.depto,
      this.ciudad,
      this.comuna,
      this.rutCompleto,
      this.nombreCompleto,
      this.numeroMatricula,
      this.regionId,
      this.comunaId,
      this.mailsocial,
      this.nombresocial,
      this.primerNombreSocial,
      this.homeImagen});

  Data.fromJson(Map<String, dynamic> json) {
    rut = json['rut'];
    dv = json['dv'];
    nombre1 = json['nombre1'];
    nombre2 = json['nombre2'];
    apellidoPaterno = json['apellidoPaterno'];
    apellidoMaterno = json['apellidoMaterno'];
    sexo = json['sexo'];
    fechaNacimiento = json['fechaNacimiento'];
    email = json['email'];
    emailUdp = json['emailUdp'];
    fono = json['fono'];
    celular = json['celular'];
    calle = json['calle'];
    numero = json['numero'];
    depto = json['depto'];
    ciudad = json['ciudad'];
    comuna = json['comuna'];
    rutCompleto = json['rutCompleto'];
    nombreCompleto = json['nombreCompleto'];
    numeroMatricula = json['numeroMatricula'];
    regionId = json['regionId'];
    comunaId = json['comunaId'];
    mailsocial = json['mailsocial'];
    nombresocial = json['nombresocial'];
    primerNombreSocial = json['primerNombreSocial'];
    homeImagen = json['homeImagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rut'] = rut;
    data['dv'] = dv;
    data['nombre1'] = nombre1;
    data['nombre2'] = nombre2;
    data['apellidoPaterno'] = apellidoPaterno;
    data['apellidoMaterno'] = apellidoMaterno;
    data['sexo'] = sexo;
    data['fechaNacimiento'] = fechaNacimiento;
    data['email'] = email;
    data['emailUdp'] = emailUdp;
    data['fono'] = fono;
    data['celular'] = celular;
    data['calle'] = calle;
    data['numero'] = numero;
    data['depto'] = depto;
    data['ciudad'] = ciudad;
    data['comuna'] = comuna;
    data['rutCompleto'] = rutCompleto;
    data['nombreCompleto'] = nombreCompleto;
    data['numeroMatricula'] = numeroMatricula;
    data['regionId'] = regionId;
    data['comunaId'] = comunaId;
    data['mailsocial'] = mailsocial;
    data['nombresocial'] = nombresocial;
    data['primerNombreSocial'] = primerNombreSocial;
    data['homeImagen'] = homeImagen;
    return data;
  }
}