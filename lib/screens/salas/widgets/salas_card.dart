import 'package:flutter/material.dart';
import 'package:udpocket/types/salas_docencia_response.dart';

class SalasCard extends StatelessWidget {
  final NodeSala sala;
  const SalasCard({Key? key, required this.sala}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[200],
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          sala.course ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          sala.code ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          sala.place ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          sala.section ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
