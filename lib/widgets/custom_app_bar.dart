import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(50);
  final String title;

  const CustomAppBarWidget({Key? key, 
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: Text(title),
    );
  }
}