import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udpocket/providers/perfil_page_provider.dart';
import 'package:udpocket/types/info_alumno_response.dart';
import 'package:udpocket/types/situacion_academica_response.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

const double _perfilImagenWidth = 150;
const double _perfilImagenHeight = 150;
const double _topCardHeight = 200;
const double _carreraTextTopOffset = 50;
const double _carreraTextLeftOffset = 20;
const double _nombreTextLeftOffset = 10;
const double _nombreTextTopOffset = 20;
const double _rutTextTopOffset = 20;
const double _rutTextLeftOffset = 10;
const double _udpTextLeftOffset = 190;

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage>
    with AutomaticKeepAliveClientMixin<PerfilPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //necesario para el keep alive

    //hacer que se pueda hacer scroll
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildPerfil(context),
        ],
      ),
    );
  }

  Widget _buildPerfil(BuildContext context) {
    return FutureBuilder(
      future: getInfoAlumno(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error al cargar la información"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final InfoAlumnoResponse infoAlumno = snapshot.data!["infoAlumno"];
        final SituacionAcademicaResponse situacionAcademica =
            snapshot.data!["situacionAcademica"];

        return Column(
          children: [
            TopPerfilCard(
                infoAlumno: infoAlumno, situacionAcademica: situacionAcademica),
            const SizedBox(
              height: 20,
            ),
            _buildPerfilInfo(context, infoAlumno),
            //boton para cerrar sesion
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                child: const Text("Cerrar Sesión"),
                onPressed: () {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.remove('udpToken');
                    context.pushReplacement('/');
                  });
                }),
          ],
        );
      },
    );
  }

  Widget _buildPerfilInfo(BuildContext context, InfoAlumnoResponse data) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email UDP"),
              subtitle: Text(data.data!.emailUdp!.toLowerCase()),
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email Personal"),
              subtitle: Text(data.data!.email!.toLowerCase()),
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Telefono"),
              subtitle: Text(data.data!.celular!),
            )),
        const SizedBox(
          height: 10,
        ),
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Dirección"),
              subtitle: Text(data.data!.calle!),
            )),
      ],
    );
  }
}

class TopPerfilCard extends StatefulWidget implements PreferredSizeWidget {
  final InfoAlumnoResponse infoAlumno;
  final SituacionAcademicaResponse situacionAcademica;
  const TopPerfilCard(
      {Key? key, required this.infoAlumno, required this.situacionAcademica})
      : super(key: key);

  static const Size barSize =
      Size.fromHeight(_topCardHeight + _perfilImagenHeight / 2);

  @override
  State<TopPerfilCard> createState() => TopPerfilCardState();

  @override
  Size get preferredSize => barSize;
}

class TopPerfilCardState extends State<TopPerfilCard>
    with AutomaticKeepAliveClientMixin<TopPerfilCard> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildTopPerfilCard(
        context, widget.infoAlumno, widget.situacionAcademica);
  }

  Widget _buildTopPerfilCard(BuildContext context, InfoAlumnoResponse data,
      SituacionAcademicaResponse situData) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: _topCardHeight,
            margin: const EdgeInsets.only(bottom: _perfilImagenHeight / 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Positioned(
              left: MediaQuery.of(context).size.width - _udpTextLeftOffset,
              child: Text(
                "udp",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.3),
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                ),
              )),
          Positioned(
            top: _topCardHeight - _perfilImagenHeight / 2,
            left: _perfilImagenWidth / 3,
            child: _buildPerfilImagen(context, data.data!.homeImagen!),
          ),
          Positioned(
            top: _topCardHeight -
                _perfilImagenHeight / 2 -
                _carreraTextTopOffset,
            left: _perfilImagenWidth / 3 - _carreraTextLeftOffset,
            child: Text(
              situData.data!.planes![0].nombreCarrera!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top:
                _topCardHeight - _perfilImagenHeight / 2 + _nombreTextTopOffset,
            left: _perfilImagenWidth / 3 +
                _perfilImagenWidth +
                _nombreTextLeftOffset,
            child: Text(
              "${data.data!.nombre1} ${data.data!.apellidoPaterno} ${data.data!.apellidoMaterno}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: _topCardHeight -
                _perfilImagenHeight / 2 +
                _nombreTextTopOffset +
                _rutTextTopOffset,
            left: _perfilImagenWidth / 3 +
                _perfilImagenWidth +
                _nombreTextLeftOffset +
                _rutTextLeftOffset,
            child: Text(
              data.data!.rutCompleto!,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerfilImagen(BuildContext context, String base64Imagen) {
    final List<int> bytesPhoto = base64.decode(base64Imagen);
    Uint8List decodedPhoto = Uint8List.fromList(bytesPhoto);
    final theme = Theme.of(context);

    return Container(
      width: _perfilImagenWidth,
      height: _perfilImagenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.scaffoldBackgroundColor, width: 5),
        image: DecorationImage(
          image: MemoryImage(decodedPhoto),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> getInfoAlumno(BuildContext context) async {
  var infoAlumno =
      await (Provider.of<PerfilPageProvider>(context, listen: false)
          .getInfoAlumno);
  var situacionResponse =
      await udpApiRequest(UdpApiMethod.get, UdpApiPath.situacionAcademica);

  return {
    "infoAlumno": infoAlumno,
    "situacionAcademica":
        SituacionAcademicaResponse.fromJson(situacionResponse.data),
  };
}
