

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udpocket/app.dart';
import 'package:udpocket/consts/udp_api_consts.dart';

class DeepLinkReciver extends StatelessWidget {
  final String code;
  const DeepLinkReciver({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAuthToken(code),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) { // Si no se pudo obtener el token
            return const Text('Error al obtener el token de autenticacion'); //TODO: Reemplazar esto por un error
          } else { // Si se pudo obtener el token
            return const App();
          }
        } else {
          return const Text('Loading...'); //TODO: Reemplazar esto por un spinner
        }
      },
    );
  }
}

const String _clientId = "15768398579-davpf46psr40hrpotvgm6a9oj7hveu09.apps.googleusercontent.com";
const String _redirectUri = "cl.udp.conectaudp:/";

Future<String?> _getAuthToken(String code) async {
  Uri googleOauthUri = Uri.parse('https://www.googleapis.com/oauth2/v4/token');

  http.Response oauthResponse = await http.post(
    googleOauthUri,
    body: {
      "code": code,
      "client_id": _clientId,
      "redirect_uri": _redirectUri,
      "grant_type": "authorization_code",
    },
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    }
  );
  
  Map<String, dynamic> oauthResponseJson;
  try{
     oauthResponseJson = jsonDecode(oauthResponse.body);
  }catch(e){
    return null;
  }
  String idToken = oauthResponseJson['id_token'];
  String accessToken = oauthResponseJson['access_token'];

  Uri googleUserInfo = Uri.parse('https://www.googleapis.com/userinfo/v2/me');
  http.Response infoResponse = await http.get(
    googleUserInfo,
    headers: {
      "Authorization":"Bearer $accessToken",
    }
  );
  String email = jsonDecode(infoResponse.body)['email'];

  Uri udpLoginUri = Uri.parse('${udpApiBaseUrl}login2');
  http.Response udpLoginResponse = await http.post(
    udpLoginUri,
    body: jsonEncode({
      "email": email,
      "idToken": idToken,
    }),
    headers: {
      "Ocp-Apim-Subscription-Key": ocpApimSubKey,
      "Content-Type": "application/json",
    }
  );
  
  String? udpToken = udpLoginResponse.headers["authorization"];
  if(udpToken == null){
    return null;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('udpToken', udpToken);

  return udpToken;
}