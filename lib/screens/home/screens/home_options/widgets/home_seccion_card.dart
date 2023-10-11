import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udpocket/providers/home_page_provider.dart';

class HomeSeccionCard extends StatelessWidget {
  final String nombre;
  final IconData icon;
  final Color color;
  final int homeIndex;
  const HomeSeccionCard(
      {Key? key,
      required this.nombre,
      required this.icon,
      required this.color,
      required this.homeIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<HomePageProvider>(context, listen: false)
            .pageController
            .jumpToPage(homeIndex);
      },
      child: Container(
        width: 400,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              nombre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
