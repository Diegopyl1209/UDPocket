import 'package:flutter/material.dart';
import 'package:udpocket/screens/home/screens/notas/notas_utils.dart';
import 'package:udpocket/types/notas_response.dart';

class Notas extends StatefulWidget {
  const Notas({super.key});

  @override
  NotasState createState() => NotasState();
}

class NotasState extends State<Notas> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NotasUtils.getNotas(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al obtener las notas'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Notas',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  _buildNotas(snapshot.data as NotasResponse),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotas(NotasResponse notas) {
    var notasNoDup =
        <NotasAlumno>[]; // al parecer no funciona usando el truco de los sets

    for (var nota in notas.data!.notasAlumno!) {
      if (!notasNoDup.contains(nota)) {
        notasNoDup.add(nota);
      }
    }

    // agrupar por año y semestre
    var notasAgrupadas = <String, List<NotasAlumno>>{};
    for (var nota in notasNoDup) {
      var key = '${nota.anio}-${nota.periodo}';
      if (notasAgrupadas.containsKey(key)) {
        notasAgrupadas[key]!.add(nota);
      } else {
        notasAgrupadas[key] = [nota];
      }
    }

    return Column(
      children: [
        for (var key in notasAgrupadas.keys)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              for (var nota in notasAgrupadas[key]!) _buildNota(nota),
            ],
          ),
      ],
    );
  }

  Widget _buildNota(NotasAlumno nota) {
    Color color;
    if (nota.estadoAcademico == 'Aprobado') {
      color = Colors.green;
    } else if (nota.estadoAcademico == 'Reprobado') {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }

    //mostrar año,semestre,asignatura,profesor,nota,estado
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${nota.anio} - ${nota.periodo}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    nota.nombreAsignatura!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    nota.nombreProfesor!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  nota.notaFinal!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
