import 'dart:async';

import '../../../util/network_verific.dart';
import '../carro.dart';
import 'favorito_service.dart';

class FavoritosBloc {
  final streamController = StreamController<List<Carros>>();
  Stream<List<Carros>> get Strea => streamController.stream;

  Future<List<Carros>> fetch() async {
    try {
      List<Carros> carros = await FavoritoService.getCarros();
      streamController.add(carros);
      return carros;
    } catch (e) {
      streamController.addError(e);
      throw const FormatException();
    }
  }

  void dispose() {
    streamController.close();
  }
}
