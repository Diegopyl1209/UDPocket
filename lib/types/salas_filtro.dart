class SalasFiltro {
  SalasDias dia;
  int? seccion;
  String busqueda;

  SalasFiltro({this.dia = SalasDias.hoy, this.seccion, this.busqueda=""});


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
