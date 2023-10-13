

import 'package:flutter/material.dart';

class SalasSearchBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(60);

  const SalasSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: const Icon(Icons.search),
          hintText: "Buscar",
          border: InputBorder.none,
          //clear text button
          suffixIcon: IconButton(
            onPressed: (){
              controller.clear();
              onChanged('');
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}