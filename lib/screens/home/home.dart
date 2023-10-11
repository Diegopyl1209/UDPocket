import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/home_page_provider.dart';
import 'package:udpocket/screens/home/screens/home_options/home_options.dart';
import 'package:udpocket/screens/home/screens/horario/horario.dart';
import 'package:udpocket/screens/home/screens/settings.dart';

import 'screens/calendario/calendario.dart';
import 'screens/notas/notas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //necesario para el keep alive
    return Scaffold(
      appBar: const HomeAppBar(),
      body: PageView(
        controller: Provider.of<HomePageProvider>(context).pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeOptions(),
          Horario(),
          Notas(),
          Calendario(),
          SettingsPage(),
        ],
      ),
    );
  }
}

Widget buildHomeNavDrawer(BuildContext context,
    {required GlobalKey<ScaffoldState> scaffoldKey}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SafeArea(
          top: false,
          child: SizedBox(
            height: 150,
            child: DrawerHeader(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Image.asset(
                  'assets/images/full_udp_logo_dark.png',
                  fit: BoxFit.fitWidth,
                )),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Provider.of<HomePageProvider>(context, listen: false)
                .pageController
                .jumpToPage(0);

            scaffoldKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Horario'),
          onTap: () {
            Provider.of<HomePageProvider>(context, listen: false)
                .pageController
                .jumpToPage(1);
            scaffoldKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Notas'),
          onTap: () {
            Provider.of<HomePageProvider>(context, listen: false)
                .pageController
                .jumpToPage(2);
            scaffoldKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Calendario'),
          onTap: () {
            Provider.of<HomePageProvider>(context, listen: false)
                .pageController
                .jumpToPage(3);
            scaffoldKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuración'),
          onTap: () {
            Provider.of<HomePageProvider>(context, listen: false)
                .pageController
                .jumpToPage(5);
            scaffoldKey.currentState!.closeDrawer();
          },
        ),
      ],
    ),
  );
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Provider.of<HomePageProvider>(context, listen: false)
              .scaffoldKey
              .currentState!
              .openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            "udp",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontFamily: GoogleFonts.openSans().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
