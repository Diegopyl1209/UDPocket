import 'package:flutter/material.dart';
import 'package:udpocket/screens/home/screens/home_options/proximas_clases/proximas_clases_utils.dart';
import 'package:udpocket/screens/home/screens/home_options/proximas_clases/widgets/proxima_clase_card.dart';
import 'package:udpocket/types/proximas_clases_response.dart';

class ProximasClases extends StatefulWidget {
  const ProximasClases({Key? key}) : super(key: key);

  @override
  State<ProximasClases> createState() => _ProximasClasesState();
}

class _ProximasClasesState extends State<ProximasClases>
    with AutomaticKeepAliveClientMixin<ProximasClases> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: ProximasClasesUtils.getProximasClases(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error al cargar la información"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildProximasClases(
              context, snapshot.data as ProximasClasesResponse);
        }
      },
    );
  }

  Widget _buildProximasClases(
      BuildContext context, ProximasClasesResponse data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var clase in data.data!) ProximaClaseCard(clase: clase),
      ],
    );
  }
}
