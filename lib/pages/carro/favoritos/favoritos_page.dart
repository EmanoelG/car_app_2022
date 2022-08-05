
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


import 'package:provider/provider.dart';
import '../../../main.dart';
import '../carro.dart';
import '../carros_listview.dart';
import 'favoritos_provider/favorito_service_provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  late List<Carros> carros;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FavoritoServiceModel>(context, listen: false).getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    FavoritoServiceModel model = Provider.of<FavoritoServiceModel>(context);
    carros = model.car;
    if (carros.isEmpty) {
      return const Center(
        child: Text('Nenhum carro nos favorito '),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CarrosListView(carros),
    );
  }

  Future<Future<List<Carros>>?> _onRefresh() async {
    FavoritoServiceModel modelCar =
        await Provider.of<FavoritoServiceModel>(context, listen: false);
    modelCar.getCarros();
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
