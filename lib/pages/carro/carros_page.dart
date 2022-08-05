import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_car/pages/carro/carros_listview.dart';
import 'package:list_car/pages/carro/carros_model.dart';
import 'package:list_car/util/text_error.dart';
import 'carro.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage({this.tipo});

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carros> carros;
  var _modelCarro = ModelCar();
  String get tipo => widget.tipo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelCarro.fetch(tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(
      builder: (_) {
        List<Carros> carros = _modelCarro.carros;
        if (_modelCarro.error != null) {
          print('ERROR >>> ' + _modelCarro.error.toString());
          return TextError('Não foi possível buscar a lista de carros !');
        }

        if (_modelCarro == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    return await _modelCarro.fetch(tipo);
  }

  @override
  bool get wantKeepAlive => true;
}
