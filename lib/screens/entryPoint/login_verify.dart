import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udpocket/screens/login.dart';
import 'package:udpocket/utils/udpApi/udp_api_request.dart';

import '../../app.dart';

class LoginVerify extends StatelessWidget {
  const LoginVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _verifyLogin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) {
            // Si está loggeado
            return const App();
          } else {
            // Si no está loggeado
            return const LoginPage();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<bool> _verifyLogin() async {
  var prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('udpToken');
  if (token == null) {
    return false;
  }

  UdpApiResponse response =
      await udpApiRequest(UdpApiMethod.get, UdpApiPath.validaSesion);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
