import 'package:flutter/material.dart';
import 'package:udpocket/screens/home/screens/calendario/calendario_utils.dart';
import 'package:udpocket/screens/home/screens/calendario/widgets/Calendario_builder.dart';
import 'package:udpocket/types/calendario_response.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CalendarioUtils.getCalendario(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al cargar calendario'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var calendario = snapshot.data as CalendarioResponse;
        return CalendarioBuilder(calendario: calendario);
      },
    );
  }
}
