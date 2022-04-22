import 'package:flutter/material.dart';
import 'package:fl_control_gastos/widgets/theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black38,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: gradientePropia(),
              child: const Icon(Icons.account_balance_wallet_outlined, size: 100, color: Colors.white,),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white,),
              title: const Text('Inicio', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'Home');
              },
            ),
            ListTile(
            
              leading: const Icon(Icons.account_balance_wallet, color: Colors.white,),
              title: const Text('Cuentas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'Cuentas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list, color: Colors.white,),
              title: const Text('Categorias', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'Categorias');
              },
            ),
            
          ],
        ),
      );
  }
}