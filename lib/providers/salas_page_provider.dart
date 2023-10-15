import 'package:flutter/material.dart';

import '../screens/salas/salasUtils.dart';
import '../types/salas_docencia_response.dart';
import '../types/salas_filtro.dart';

class SalasPageProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  List<NodeSala> salas = [];
  SalasFiltro filtro = SalasFiltro();

  SalasPageProvider() {
    controller.addListener(() {
      notifyListeners();
    });
  }

  void updateSalas(List<NodeSala> salas) {
    this.salas = salas;
  }

  void updateController(String text) {
    controller.text = text;
  }

  void clearController() {
    controller.clear();
  }

  void updateFiltro(SalasFiltro filtro) {
    this.filtro = filtro;
    notifyListeners();
  }

  void clearFiltro() {
    filtro = SalasFiltro();
    notifyListeners();
  }

  List<NodeSala> getFilteredSalas() {
    return filterSalas(salas, filtro, busqueda: controller.text);
  }
}
