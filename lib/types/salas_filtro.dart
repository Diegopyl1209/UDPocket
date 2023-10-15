class SalasFiltro {
  SalasDias dia;
  int? seccion;

  SalasFiltro({this.dia = SalasDias.hoy, this.seccion});
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
