import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Configuración',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Modo oscuro'),
            trailing: Switch(
              value: Provider.of<SettingsProvider>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<SettingsProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
