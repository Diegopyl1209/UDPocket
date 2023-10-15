import 'package:udpocket/types/salas_docencia_response.dart';
import 'package:udpocket/types/salas_filtro.dart';

List<NodeSala> getOnlyAvailableSalas(List<NodeSala> salas) {
  //limpiar las salas que no tengan nombre, codigo o lugar ya sean nulos o vacios
  List<NodeSala> availableSalas = [];
  for (var sala in salas) {
    if (sala.course != null &&
        sala.course!.isNotEmpty &&
        sala.code != null &&
        sala.code!.isNotEmpty &&
        sala.place != null &&
        sala.place!.isNotEmpty) {
      availableSalas.add(sala);
    }
  }
  return availableSalas;
}

List<NodeSala> filterSalas(List<NodeSala> salas, SalasFiltro filtro,
    {String busqueda = ''}) {
  List<NodeSala> filteredSalas = [];
  List<String> busquedaTerms = busqueda.split(' ');
  //normalizar busqueda
  for (var i = 0; i < busquedaTerms.length; i++) {
    busquedaTerms[i] = busquedaTerms[i].toLowerCase();
  }

  for (var sala in salas) {
    bool addSala = busquedaTerms.every((element) {
      return sala.course!.toLowerCase().contains(element) ||
          sala.teacher!.toLowerCase().contains(element);
    });
    if (filtro.seccion != null) {
      addSala = addSala && sala.section == filtro.seccion!.toString();
    }
    if (filtro.dia != null) {
      if (filtro.dia.index == 8) {
        int dia = DateTime.now().weekday;
        if (sala.day == dia) {
          addSala = addSala && true;
        } else {
          addSala = false;
        }
      } else {
        addSala = addSala && sala.day == filtro.dia.index;
      }
    }

    if (addSala) {
      filteredSalas.add(sala);
    }
  }
  return filteredSalas;
}
