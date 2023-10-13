


import 'package:udpocket/types/salas_docencia_response.dart';
import 'package:udpocket/types/salas_filtro.dart';

List<NodeSala> getOnlyAvailableSalas(List<NodeSala> salas){
  //limpiar las salas que no tengan nombre, codigo o lugar ya sean nulos o vacios
  List<NodeSala> availableSalas = [];
  for (var sala in salas) {
    if (sala.course != null && sala.course!.isNotEmpty && sala.code != null && sala.code!.isNotEmpty && sala.place != null && sala.place!.isNotEmpty) {
      availableSalas.add(sala);
    }
  }
  return availableSalas;
}

List<NodeSala> filterSalas(List<NodeSala> salas, SalasFiltro filtro){
  List<NodeSala> filteredSalas = [];
  List<String> busqueda = filtro.busqueda.split(' ');
  //normalizar busqueda
  for (var i = 0; i < busqueda.length; i++) {
    busqueda[i] = busqueda[i].toLowerCase();
  }

  for (var sala in salas) {

    bool courseinBusqueda = false;
    bool teacherinBusqueda = false;

    for (var element in busqueda) {
      if(sala.course!.toLowerCase().contains(element)){
        courseinBusqueda = true;
      }
      if(sala.teacher!.toLowerCase().contains(element)){
        teacherinBusqueda = true;
      }
    }


    if (courseinBusqueda || sala.section!.contains(filtro.seccion.toString()) || teacherinBusqueda ) {
      filteredSalas.add(sala);
    }
  }
  return filteredSalas;
}