import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black38,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Column(
                  children: const [
                    Text('Control de Gastos', style: TextStyle(fontSize: 30, color: Colors.white)),
                    Icon(Icons.account_balance_wallet_outlined, size: 100, color: Colors.white,)
                  ],
              ),
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