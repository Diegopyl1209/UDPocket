import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';

import '../../../../../types/calendario_response.dart';
import '../calendario_utils.dart';

class CalendarioBuilder extends StatefulWidget {
  final CalendarioResponse calendario;

  const CalendarioBuilder({Key? key, required this.calendario})
      : super(key: key);

  @override
  State<CalendarioBuilder> createState() => _CalendarioBuilderState();
}

class _CalendarioBuilderState extends State<CalendarioBuilder> {
  int _selectedIndex = 0;

  late final List<EventoCalendario> _eventos = widget.calendario.data!
      .where((element) => CalendarioUtils.getFormatedFecha(element)
          .isAfter(DateTime.now().copyWith(day: 0)))
      .toList();

  //agrupo los eventos por fecha
  late final Map<DateTime, List<EventoCalendario>> _eventosPorDia = {
    for (var evento in _eventos)
      CalendarioUtils.getFormatedFecha(evento): _eventos
          .where((element) =>
              CalendarioUtils.getFormatedFecha(element) ==
              CalendarioUtils.getFormatedFecha(evento))
          .toList()
  };

  late DateTime _fechaSeleccionada;

  @override
  Widget build(BuildContext context) {
    _fechaSeleccionada = _eventosPorDia.keys.toList()[_selectedIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Calendario',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                CalendarioUtils.getNombreDiaMes(_fechaSeleccionada),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: _selectedIndex == 0 ? 0.5 : 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      if (_selectedIndex == 0) return;
                      setState(() {
                        _selectedIndex--;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Opacity(
                opacity: _selectedIndex == _eventos.length - 1 ? 0.5 : 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    color: _selectedIndex == _eventos.length - 1
                        ? Colors.grey
                        : Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {
                      if (_selectedIndex == _eventos.length - 1) return;
                      setState(() {
                        _selectedIndex++;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _fechasCarrousel(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _eventosList(),
          ),
        ],
      ),
    );
  }

  Widget _fechasCarrousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _eventosPorDia.keys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              color: _selectedIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: SizedBox(
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          CalendarioUtils.getNombreDiaShort(
                            _eventosPorDia.keys.toList()[index],
                          ),
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _eventosPorDia.keys.toList()[index].day.toString(),
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _eventosList() {
    return ListView.builder(
      itemCount: _eventosPorDia[_fechaSeleccionada]!.length,
      itemBuilder: (context, index) {
        return _eventoCard(_eventosPorDia[_fechaSeleccionada]![index]);
      },
    );
  }

  Widget _eventoCard(EventoCalendario evento) {
    //mostrar titulo, descripcion, fecha de inicio y fin (solo si dura mas de un dia), y boton para agregar a calendario
    DateTime fechaInicio = CalendarioUtils.getFormatedFecha(evento);
    bool _duraMasDeUnDia =
        fechaInicio.day != CalendarioUtils.getFormatedFechaTermino(evento).day;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                evento.titulo!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                evento.descripcion!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${CalendarioUtils.getNombreDia(fechaInicio)}, ${fechaInicio.day} de ${CalendarioUtils.getNombreMes(fechaInicio)}",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              if (_duraMasDeUnDia)
                Text(
                  "Hasta ${CalendarioUtils.getNombreDia(CalendarioUtils.getFormatedFechaTermino(evento))}, ${CalendarioUtils.getFormatedFechaTermino(evento).day} de ${CalendarioUtils.getNombreMes(CalendarioUtils.getFormatedFechaTermino(evento))}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      Event event = Event(
                        title: evento.titulo!,
                        description: evento.descripcion!,
                        startDate: CalendarioUtils.getFormatedFecha(evento),
                        endDate:
                            CalendarioUtils.getFormatedFechaTermino(evento),
                      );
                      Add2Calendar.addEvent2Cal(event);
                    },
                    child: const Text("Agregar a calendario"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
