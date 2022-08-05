import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/nav.dart';
import '../../util/sql/db_helper.dart';
import '../carro/home_page.dart';

import '../login/login_page.dart';
import '../login/usuario.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 15), () {
    //     push(context, LoginPage());
    //   });

    //Inicializa banco de dados.
    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(Duration(seconds: 3));
    // Verifica se o usuario manteve logado.
    Future<Usuario> futureC = Usuario.get();
    futureC.then((Usuario user) {
      if (user != null) {
        push(context, HomePage(), replace: false);
      }
    });

    Future.wait([futureA, futureB, futureC]).then(
      (List values) {
        Usuario user = values[2];
        if (user != null) {
          push(context, HomePage(), replace: false);
        } else {
          push(context, LoginPage(), replace: false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      )),
    );
  }
}
