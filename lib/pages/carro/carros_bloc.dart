// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:async';

import 'package:list_car/pages/carro/carro.dart';
import 'package:list_car/pages/carro/carros_api.dart';
import 'package:list_car/pages/carro/favoritos/carro_dao.dart';

import '../../util/network_verific.dart';
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
  }

  void dispose() {
    _streamController.close();
  }
}
