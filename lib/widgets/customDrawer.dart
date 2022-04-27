import 'package:flutter/material.dart';
import 'package:fl_control_gastos/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blocs.dart';

class CustomDrawerWidget extends StatefulWidget {
  CustomDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Colors.black38,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: gradientePropia(),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                //tileColor:true? Colors.white12:Colors.transparent,
                title: const Text(
                  'Inicio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  if (state.screen != 'Home') {
                    setState(() {
                      context.read<NavBloc>().add(GetScreen('Home'));
                    });        
                    Navigator.pushReplacementNamed(context, 'Home');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                title: const Text(
                  'Cuentas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  if (state.screen != 'Cuentas') {
                    setState(() {
                      context.read<NavBloc>().add(GetScreen('Cuentas'));
                    });        
                    Navigator.pushReplacementNamed(context, 'Cuentas');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                title: const Text('Categorias',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                onTap: () {
                  if (state.screen != 'Categorias') {
                    setState(() {
                      context.read<NavBloc>().add(GetScreen('Categorias'));
                    });        
                    Navigator.pushReplacementNamed(context, 'Categorias');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
