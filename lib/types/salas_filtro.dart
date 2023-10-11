class SalasFiltro {
  SalasDias dia = SalasDias.hoy;
  int? seccion;
  String? busqueda;

  SalasFiltro({this.dia = SalasDias.hoy, this.seccion, this.busqueda});

  SalasFiltro.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    seccion = json['seccion'];
    busqueda = json['busqueda'];
  }
}

enum SalasDias {
  hoy,
  lunes,
  martes,
  miercoles,
  jueves,
  viernes,
  sabado,
}
