import 'package:flutter/material.dart';

import '../../carro.dart';
import '../favorito_service.dart';

class FavoritoServiceModel extends ChangeNotifier {
  List<Carros> car = [];
  Future<List<Carros>> getCarros() async {
    car = await FavoritoService.getCarros();
    notifyListeners();
    throw const FormatException();
  }
}
