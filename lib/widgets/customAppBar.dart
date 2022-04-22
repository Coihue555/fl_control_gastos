import 'package:flutter/material.dart';

class AppBarPropio extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(100);
  final String title;

  const AppBarPropio({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: Text(title),
    );
  }
}