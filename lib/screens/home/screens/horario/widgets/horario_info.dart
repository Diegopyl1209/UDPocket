import 'package:flutter/material.dart';

import '../../../../../types/horario_response.dart';

class HorarioInfo extends StatelessWidget {
  final Info info;
  const HorarioInfo({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(info.nombreAsig!),
      subtitle: Text("${info.horaInicio} - ${info.horaTermino}"),
      trailing: Text(info.evento!),
    );
  }
}
