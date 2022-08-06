import 'dart:async';
import '../../util/network_verific.dart';
import 'carro.dart';
import 'carros_api.dart';
import 'favoritos/carro_dao.dart';

//IMPLEMENTA CARRO BLOC
class CarrosBloc {
  final _streamController = StreamController<List<Carros>>();
  Stream<List<Carros>> get Strea => _streamController.stream;

  Future<List<Carros>> fetch(tipo) async {
    try {
      bool netWorkon = await isNetWork();
      if (!netWorkon) {
        List<Carros> car = await CarroDAO().findAllByTipo(tipo);
        _streamController.add(car);
        return car;
      }
      List<Carros> carros = await CarrosApi.getCarros(tipo);
      _streamController.add(carros);
    } catch (e) {
      _streamController.addError(e);
    }
    throw Exception();
  }

  void dispose() {
    _streamController.close();
  }
}
