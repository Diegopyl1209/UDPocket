import 'package:flutter/material.dart';
import 'package:udpocket/screens/home/screens/horario/widgets/horario_dia.dart';
import 'package:udpocket/types/horario_response.dart';

import 'horario_utils.dart';

class Horario extends StatelessWidget {
  const Horario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Horario',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: HorarioUtils.getHorario(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error al cargar la información"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return _buildHorario(
                        horarioResponse: snapshot.data as HorarioResponse);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorario({required HorarioResponse horarioResponse}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: horarioResponse.data!.horarioAlumno!.length,
      itemBuilder: (context, index) {
        return HorarioDia(
            horarioAlumno: horarioResponse.data!.horarioAlumno![index]);
      },
    );
  }
}
