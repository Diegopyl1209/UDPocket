import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/home_page_provider.dart';
import 'package:udpocket/screens/home/home.dart';
import 'package:udpocket/screens/perfil.dart';
import 'package:udpocket/screens/salas/salas.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with AutomaticKeepAliveClientMixin<App> {
  var _selectedIndex = 1;
  late final PageController _pageController =
      PageController(initialPage: _selectedIndex);

  static const int _homeIndex = 1;
  late final List<Widget> _pages = [
    const Salas(),
    const HomePage(),
    const PerfilPage(),
  ];

  late final GlobalKey<ScaffoldState> scaffoldKey =
      Provider.of<HomePageProvider>(context, listen: false)
          .scaffoldKey; // esto es para el drawer

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); //necesario para el keep alive

    return Scaffold(
      key: scaffoldKey,
      drawer: _selectedIndex == _homeIndex
          ? buildHomeNavDrawer(context, scaffoldKey: scaffoldKey)
          : null,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const AlwaysScrollableScrollPhysics(),
          onPageChanged: (value) => setState(() => _selectedIndex = value),
          children: _pages,
        ),
      ),
      bottomNavigationBar: SafeArea(child: _buildNavBar(context)),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          //hacer las esquinas redondeadas
          borderRadius: BorderRadius.circular(20),
          child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                );
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.apartment),
                  selectedIcon: Icon(Icons.apartment_outlined),
                  label: 'Salas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home_outlined),
                  label: 'Inicio',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  selectedIcon: Icon(Icons.person_outlined),
                  label: 'Perfil',
                ),
              ])),
    );
  }
}
