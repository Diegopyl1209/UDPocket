import 'package:flutter/material.dart';
import 'package:udpocket/types/salas_filtro.dart';

class Salas extends StatefulWidget {
  const Salas({Key? key}) : super(key: key);

  @override
  State<Salas> createState() => _SalasState();
}

class _SalasState extends State<Salas> {
  final SalasFiltro _salasFiltro = SalasFiltro();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salas'),
      ),
      body: Center(
        child: Text('Salas'),
      ),
    );
  }
}
