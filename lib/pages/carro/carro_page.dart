import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../util/alert.dart';
import '../../util/nav.dart';
import '../login/api_response.dart';
import '../widgets/utilText.dart';
import 'carro.dart';
import 'carro_form_page.dart';
import 'carros_api.dart';
import 'favoritos/favorito_service.dart';
import 'loremipsum_api.dart';

class CarroPage extends StatefulWidget {
  Carros carro;
  CarroPage(this.carro);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _lorimpsumBloc = LorimpsumBloc();

  Color colorFavorito = Colors.red;

  Carros get car => widget.carro;
  @override
  void initState() {
    super.initState();
    FavoritoService.isFavorito(car).then((bool Favorito) {
      setState(() {
        colorFavorito = Favorito ? Colors.red : Colors.grey;
      });
    });
    _lorimpsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context, car),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.carro.nome),
      actions: <Widget>[
        IconButton(
          onPressed: _onClickMap,
          icon: Icon(Icons.place),
        ),
        IconButton(
          onPressed: _onClickVideoCam,
          icon: Icon(Icons.videocam),
        ),
        PopupMenuButton<String>(
          onSelected: (String value) => _onClickPopoupMenu(value),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: 'Editar',
                child: Text('Editar'),
              ),
              PopupMenuItem(
                value: 'Deletar',
                child: Text('Deletar'),
              ),
              PopupMenuItem(
                value: 'Share',
                child: Text('Share'),
              ),
            ];
          },
        ),
      ],
    );
  }

  _body(context, Carros car) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          cardListView(car, context),
        ],
      ),
    );
  }

  Card cardListView(Carros c, BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: CachedNetworkImage(
              imageUrl: c.urlFoto,
              width: 350,
            )),
            Container(
              // onPressed: () => _onClickCarro(context, c),
              child: _descricaoCarro(),
            ),
            Divider(),
            _blocoDois()
          ],
        ),
      ),
    );
  }

  Row _descricaoCarro() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.carro.nome,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.carro.tipo,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        _blocoUm(),
      ],
    );
  }

  Row _blocoUm() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: _onClickFavorito,
          icon: Icon(
            Icons.favorite,
            // color: Colors.red,
            color: colorFavorito,
            size: 40,
          ),
        ),
        IconButton(
          onPressed: _onCliShare,
          icon:const Icon(
            Icons.share,
            color: Colors.black,
            size: 40,
          ),
        ),
      ],
    );
  }

  void _onClickVideoCam() {
    if (car.urlVideo != null && car.urlVideo.isEmpty) {
      canLaunchUrl(Uri.parse(car.urlVideo));
    } else
      launch(('https://www.youtube.com/watch?v=iZq0u3quAqo'));

    //alert(context, 'Erro, esse carro nao possui video !');
  }

  void _onClickMap() {}

  _onClickPopoupMenu(String value) {
    switch (value) {
      case "Editar":
        push(
          context,
          CarroFormPage(
            car: this.car,
          ),
        );
        break;
      case "Deletar":
        deletarCarro();
        break;
      case "Share":
        print('Compartilhando !!');
        break;
      default:
    }
  }

  void _onClickFavorito() async {
    bool favoritar = await FavoritoService.Favoritar(context, car);
    setState(
      () {
        colorFavorito = favoritar ? Colors.red : Colors.grey;
      },
    );
  }

  void _onCliShare() {}
  void dispose() {
    super.dispose();
    _lorimpsumBloc.dispose();
  }

  _blocoDois() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<String>(
          stream: _lorimpsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return TextUtil(snapshot.data.toString());
          },
        ),
      ],
    );
  }

  Future<void> deletarCarro() async {
    ApisResponse<bool> response = await CarrosApi.delete(car);
    if (response.ok) {
      alert(context, "Carro deletado com sucesso !", callback: () {
        Navigator.pop(context);
      });
    } else {
      print('ERRORR');
      alert(context, response.msg);
    }
  }
}
