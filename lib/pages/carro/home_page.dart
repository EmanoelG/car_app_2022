import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../DrawerList.dart';
import '../../util/nav.dart';
import '../../util/prefs.dart';
import '../colors.dart';
import 'carro_form_page.dart';
import 'carros_api.dart';
import 'carros_page.dart';
import 'favoritos/favoritos_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    Future<int> future = Prefs.getInt('tabIdx');
    future.then((int value) => _tabController.index = value);

    _tabController.addListener(
      () {
        Prefs.setInt('tabIdx', _tabController.index);
      },
    );
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");
    _tabController = TabController(length: 4, vsync: this);
    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Clássicos',
            ),
            Tab(
              text: 'Esportivos',
            ),
            Tab(
              text: 'Luxuosos',
            ),
            Tab(
              text: 'Favoritos',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosPage(
            tipo: TipoCarro.classicos,
          ),
          CarrosPage(
            tipo: TipoCarro.esportivos,
          ),
          CarrosPage(
            tipo: TipoCarro.luxo,
          ),
          FavoritosPage()
        ],
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }
}
