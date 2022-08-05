import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../../../main.dart';
import '../carro.dart';
import 'carro_dao.dart';
import 'favorito.dart';
import 'favorito.dart';
import 'favorito_dao.dart';
import 'favoritos_provider/favorito_service_provider.dart';

class FavoritoService {
  static Future<bool> Favoritar(context, Carros c) async {
    Favorito f = Favorito.fromCarro(c);
    final dao = FavoriotDAO();
    final exists = await dao.exists(c.id);

    if (exists) {
      dao.delete(c.id);
      print('Existe');

      Provider.of<FavoritoServiceModel>(context, listen: false).getCarros();
      return false;
    } else {
      dao.save(f);
      print('Save');

      Provider.of<FavoritoServiceModel>(context, listen: false).getCarros();
      return true;
    }
  }

  static Future<List<Carros>> getCarros() async {
    // SELECT * from carro c, favorito f where c.id = f.id;
    List<Carros> carr = await CarroDAO()
        .query("SELECT * from carro c, favorito f where c.id = f.id;");
    print('return carros $carr');
    return carr;
  }

  static Future<bool> isFavorito(Carros c) async {
    final carr = CarroDAO();
    final exists = await carr.exists(c.id);
    return exists;
  }
}
