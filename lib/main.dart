import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/home_page_provider.dart';
import 'package:udpocket/providers/perfil_page_provider.dart';
import 'package:udpocket/screens/entryPoint/deeplink_reciver.dart';
import 'package:udpocket/screens/entryPoint/login_verify.dart';
import 'package:udpocket/utils/themes.dart';

import 'providers/settings_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => PerfilPageProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<SettingsProvider>(context, listen: false).loadSettings(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error al cargar la información"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const _MainApp();
        } else {
          return Container();
        }
      },
    );
  }
}

class _MainApp extends StatelessWidget {
  const _MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<SettingsProvider>(context).isDarkMode;
    initializeDateFormatting('es'); // Necesario para el formato de fechas
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark));

    return MaterialApp.router(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      title: "UDPocket",
      routerConfig: router,
    );
  }
}

final router = GoRouter(
    errorBuilder: (context, state) {
      //TODO: algunas veces go_router no funciona bien, hay que arreglarlo
      //intentar verificar el login antes de enviar algun error
      try{
        return _loginVerifyFlow(context, state);
      }catch(e){
        return Scaffold(
        body: Center(
          child: Text(
              'Error: ${state.error}'), //TODO: Cambiar esto por un pokemon o algo
        ),
      );
      }


    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return _loginVerifyFlow(context, state);
        },
      ),
    ]);


  _loginVerifyFlow(BuildContext context, dynamic state) {
  String? code = state.uri.queryParametersAll['code']?[0];
  if (code == null) {
    return const LoginVerify();
  } else {
    try {
      return DeepLinkReciver(code: code);
    } catch (e) {
      return const LoginVerify();
    }
  }
}