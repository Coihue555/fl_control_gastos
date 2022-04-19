import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Control de Gastos', style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
        ListTile(
          title: const Text('Cuentas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          onTap: () {
            Navigator.pushNamed(context, 'Cuentas');
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Categorias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          onTap: () {
            Navigator.pushNamed(context, 'Categorias');
          },
        ),
      ],
    ),
      );
  }
}