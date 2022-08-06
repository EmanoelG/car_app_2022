import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_car_app/pages/login/usuario.dart';
import 'package:new_car_app/util/nav.dart';

import 'pages/login/login_page.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  UserAccountsDrawerHeader _heard(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome ?? ''),
      accountEmail: Text(user.email ?? ''),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future future = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<dynamic>(
              future: future,
              builder: (context, snapshot) {
                Usuario? user = snapshot.data;
                return user != null
                    ? _heard(user)
                    : Container(
                        child: Text('Vazio '),
                      );
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: const Text('Favoritos'),
              subtitle: const Text('Mais informações'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                print('clicou favoritos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ajuda'),
              subtitle: const Text('Mais informações'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                print('clicou favoritos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Exit'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
