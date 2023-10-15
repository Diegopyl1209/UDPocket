// este widget es el que se encarga de mostrar las secciones de la apliacion, es decir, las opciones de Proximas clases, ramos, etc.
// las muestra en forma de tarjetas
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/perfil_page_provider.dart';

import 'package:udpocket/screens/home/screens/home_options/widgets/home_seccion_card.dart';
import 'package:udpocket/screens/home/screens/home_options/proximas_clases/proximas_clases.dart';
import 'package:udpocket/types/info_alumno_response.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<PerfilPageProvider>(context, listen: false)
            .getInfoAlumno,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error al cargar la información"),
            );
          } else if (snapshot.hasData) {
            return _buildHomeOptions(context,
                infoAlumno: snapshot.data as InfoAlumnoResponse);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildHomeOptions(BuildContext context,
      {required InfoAlumnoResponse infoAlumno}) {
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
                  'Hola,',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${infoAlumno.data!.nombre1!} ${infoAlumno.data!.apellidoPaterno!}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              _buildSecciones(context),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Horario del dia",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const ProximasClases(),
            ],
          ),
        ),
      ),
    );
  }

  static final secciones = [
    {
      'nombre': 'Horario',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
      'homeIndex': 1,
    },
    {
      'nombre': 'Notas',
      'icon': Icons.note,
      'color': Colors.orange,
      'homeIndex': 2,
    },
    {
      'nombre': 'Calendario udp',
      'icon': Icons.calendar_month,
      'color': Colors.red,
      'homeIndex': 3,
    },
    /*
    {
      'nombre': 'Ramos',
      'icon': Icons.book,
      'color': Colors.green,
      'homeIndex': 3, //TODO: cambiar esto
    },*/
  ];

  Widget _buildSecciones(BuildContext context) {
    //hacer carrusel de secciones
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        animateToClosest: true,
        autoPlay: true,
        initialPage: secciones.length,
        enlargeCenterPage: true,
      ),
      items: secciones
          .map((seccion) => HomeSeccionCard(
                nombre: seccion['nombre'] as String,
                icon: seccion['icon'] as IconData,
                color: seccion['color'] as Color,
                homeIndex: seccion['homeIndex'] as int,
              ))
          .toList(),
    );
  }
}
