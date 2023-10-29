import 'package:flutter/material.dart';
import 'package:udpocket/types/salas_docencia_response.dart';

class SalasCard extends StatelessWidget {
  final NodeSala sala;

  const SalasCard({Key? key, required this.sala}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor(sala);
    final iconData = _getIconData(sala);
    final containerColor = _getContainerColor(sala);
    final placeInfo = _buildPlaceInfo(sala, containerColor);

    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, iconData, containerColor),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: placeInfo,
            ),
          ),
          const SizedBox(height: 15),
          _buildSectionAndDayInfo(sala, containerColor),
        ],
      ),
    );
  }

  Color _getCardColor(NodeSala sala) {
    final codeSuffix = sala.code?.substring(sala.code!.length - 3);
    switch (codeSuffix) {
      case "CAT":
        return const Color(0xff3362CC);
      case "AYU":
        return const Color(0xff248484);
      default:
        return const Color(0xff3362CC);
    }
  }

  IconData _getIconData(NodeSala sala) {
    final codeSuffix = sala.code?.substring(sala.code!.length - 3);
    switch (codeSuffix) {
      case "CAT":
        return Icons.calendar_today;
      case "AYU":
        return Icons.school;
      default:
        return Icons.calendar_today;
    }
  }

  Color _getContainerColor(NodeSala sala) {
    final codeSuffix = sala.code?.substring(sala.code!.length - 3);
    return codeSuffix == "AYU" ? const Color(0xff27B893) : Colors.blue;
  }

  List<Widget> _buildPlaceInfo(NodeSala sala, Color colorContainer) {
    if (sala.place != null &&
        sala.place!.toLowerCase() != 'sim' &&
        sala.place!.contains('.')) {
      final placeParts = sala.place?.split('.');
      return [
        _buildInfoContainer("Edificio: ", placeParts![0], colorContainer),
        //const SizedBox(width: 15),
        _buildInfoContainer("Piso: ", placeParts[1], colorContainer),
        //const SizedBox(width: 15),
        _buildInfoContainer("Sala: ", placeParts[2], colorContainer),
      ];
    } else {
      return [_buildInfoContainer("Lugar: ", sala.place ?? '', colorContainer)];
    }
  }

  Widget _buildHeader(
      BuildContext context, IconData iconData, Color containerColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              alignment: Alignment.centerLeft,
              child: Text(
                sala.course ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              alignment: Alignment.centerLeft,
              child: Text(
                "${sala.code ?? ''} • ${sala.teacher ?? ''}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoContainer(String label, String text, Color colorContainer) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSectionAndDayInfo(NodeSala sala, Color colorContainer) {
    String _getDayName(int day) {
      switch (day) {
        case 1:
          return "Lunes";
        case 2:
          return "Martes";
        case 3:
          return "Miércoles";
        case 4:
          return "Jueves";
        case 5:
          return "Viernes";
        case 6:
          return "Sábado";
        case 7:
          return "Domingo";
        default:
          return "Nosé";
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //const SizedBox(width: 15),
          _buildInfoContainer("Sección: ", sala.section ?? '', Colors.blue),
          //const SizedBox(width: 15),
          //_buildInfoContainer("Día: ", _getDayName(sala.day ?? 0), Colors.blue),
          //const SizedBox(width: 5),
          _buildInfoContainer("Inicio: ",
              sala.start?.replaceFirst(":00", "") ?? '', colorContainer),
          //const SizedBox(width: 15),
          _buildInfoContainer("Termino: ",
              sala.finish?.replaceFirst(":00", "") ?? '', colorContainer),
        ],
      ),
    );
  }
}
