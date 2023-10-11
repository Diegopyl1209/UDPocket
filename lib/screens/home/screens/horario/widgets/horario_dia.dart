import 'package:flutter/material.dart';
import 'package:udpocket/screens/home/screens/horario/widgets/horario_info.dart';

import '../../../../../types/horario_response.dart';

class HorarioDia extends StatelessWidget {
  final HorarioAlumno horarioAlumno;
  const HorarioDia({Key? key, required this.horarioAlumno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(horarioAlumno.nombreD!),
      children: [
        for (var info in horarioAlumno.info!) HorarioInfo(info: info),
      ],
    );
  }
}
