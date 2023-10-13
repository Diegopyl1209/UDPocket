import 'package:flutter/material.dart';
import 'package:udpocket/screens/salas/widgets/salas_card.dart';
import 'package:udpocket/screens/salas/widgets/salas_search_bar.dart';
import 'package:udpocket/utils/udpApi/docencia_salas_api.dart';

import '../../types/salas_docencia_response.dart';
import '../../types/salas_filtro.dart';
import 'salasUtils.dart';


class Salas extends StatefulWidget {
  static final salasDocencia = getSalasDocencia();
  const Salas({Key? key}) : super(key: key);

  @override
  State<Salas> createState() => _SalasState();
}

class _SalasState extends State<Salas> {
  TextEditingController controller = TextEditingController();
  List<NodeSala> salas = [];
  List<NodeSala> filteredSalas = [];

  @override
  Widget build(BuildContext context) {

    SalasFiltro filtro = SalasFiltro(
      busqueda: controller.text,
      //TODO: FILTROS
    );

    return Scaffold(
      appBar: SalasSearchBar(controller: controller, onChanged: (value) {
        setState(() {
          
        });
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //TODO: FILTROS
          });
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: Salas.salasDocencia,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError){
            return const Center(child: Text('Error'));
          }
          salas = getOnlyAvailableSalas(snapshot.data!.getSalas());
          filteredSalas = filterSalas(salas, filtro);

          print("rebuild");
          return ListView(
            children: filteredSalas.map((sala) => SalasCard(sala: sala)).toList(),
          );
        },
      )
    );
  }
}
