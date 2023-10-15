import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/screens/salas/widgets/salas_card.dart';
import 'package:udpocket/screens/salas/widgets/salas_search_bar.dart';
import 'package:udpocket/utils/udpApi/docencia_salas_api.dart';

import '../../providers/salas_page_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var salasProvider = Provider.of<SalasPageProvider>(context, listen: false);
    TextEditingController controller = salasProvider.controller;

    return Scaffold(
        appBar: SalasSearchBar(
          controller: controller,
          onChanged: (value) {
            salasProvider.updateController(value);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showFilterSheet(context);
          },
          child: const Icon(Icons.filter_alt),
        ),
        body: FutureBuilder(
          future: Salas.salasDocencia,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }

            salasProvider
                .updateSalas(getOnlyAvailableSalas(snapshot.data!.getSalas()));
            return buildSalasPage(context);
          },
        ));
  }

  Widget buildSalasPage(BuildContext context) {
    var salasProvider = Provider.of<SalasPageProvider>(context, listen: true);
    List<NodeSala> filteredSalas = salasProvider.getFilteredSalas();
    return ListView(
      children: filteredSalas.map((sala) => SalasCard(sala: sala)).toList(),
    );
  }

  //Filtro sheet
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _buildFilterSheet(context);
        });
  }

  Widget _buildFilterSheet(context) {
    var salasProvider = Provider.of<SalasPageProvider>(context, listen: false);
    SalasFiltro filtro = salasProvider.filtro;

    const possibleDays = <SalasDias, String>{
      SalasDias.hoy: 'Hoy',
      SalasDias.lunes: 'Lunes',
      SalasDias.martes: 'Martes',
      SalasDias.miercoles: 'Miercoles',
      SalasDias.jueves: 'Jueves',
      SalasDias.viernes: 'Viernes',
    };

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filtrar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        salasProvider.clearFiltro();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Limpiar',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dia'),
                    DropdownMenu<SalasDias>(
                      controller: TextEditingController(
                        text: possibleDays[filtro.dia] ?? 'Hoy',
                      ),
                      onSelected: (value) {
                        setState(() {
                          filtro.dia = value ?? SalasDias.hoy;
                        });
                      },
                      dropdownMenuEntries: possibleDays.entries
                          .map((e) =>
                              DropdownMenuEntry(value: e.key, label: e.value))
                          .toList(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sección'),
                    DropdownMenu<int?>(
                      controller: TextEditingController(
                        text: filtro.seccion?.toString() ?? 'Todas',
                      ),
                      onSelected: (value) {
                        setState(() {
                          filtro.seccion = value;
                        });
                      },
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      menuHeight: MediaQuery.of(context).size.height / 2,
                      dropdownMenuEntries: [
                        const DropdownMenuEntry(value: null, label: 'Todas'),
                        for (int i = 1; i <= 20; i++)
                          DropdownMenuEntry(value: i, label: i.toString()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    salasProvider.updateFiltro(filtro);
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
