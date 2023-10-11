import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/udp_api_consts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Uri loginUri = Uri.parse(googleLoginUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              child: const Text("Iniciar sesión con Google"),
              onPressed: () async {
                try {
                  if (Platform.isIOS) {
                    await launchUrl(loginUri,
                        mode: LaunchMode.externalApplication);
                  } else {
                    await launchUrl(
                      loginUri,
                    );
                  }
                } catch (e) {
                  throw Exception("Error al iniciar sesión con Google");
                }
              })
        ],
      )),
    );
  }
}
