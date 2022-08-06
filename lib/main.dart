import 'package:flutter/material.dart';
import 'package:new_car_app/pages/carro/favoritos/favoritos_provider/favorito_service_provider.dart';
import 'package:new_car_app/pages/widgets/splashpage.dart';

import 'package:provider/provider.dart';
import 'pages/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritoServiceModel>(
          create: (context) => FavoritoServiceModel(),
          // dispose: (context, bloc) => bloc.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: corfUnco,
          primarySwatch: Colors.red,
        ),
        home: SplashPage(),
      ),
    );
  }
}
