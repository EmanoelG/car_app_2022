// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../util/alert.dart';
import '../login/api_response.dart';
import 'carro.dart';
import 'carros_api.dart';

class CarroFormPage extends StatefulWidget {
   Carros? car;

  CarroFormPage({this.car});

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  late XFile _file;
  late String _imagePath;

  Carros? get carro => widget.car;

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro!.nome;
      tDesc.text = carro!.descricao;
      _radioIndex = getTipoInt(carro!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          carro != null ? carro!.nome : "Novo Carro",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  _form() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          const Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          const Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          TextFormField(
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: valitadorCar,
            style: const TextStyle(color: Colors.blue, fontSize: 20),
            decoration: const InputDecoration(
              hintText: '',
              labelText: 'Nome',
            ),
          ),
          TextFormField(
            controller: tDesc,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              hintText: '',
              labelText: 'Descrição',
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              color: Colors.blue,
              child: _showProgress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
              onPressed: _onClickSalvar,
            ),
          ),
        ],
      ),
    );
  }

  String? valitadorCar(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  _headerFoto() {
    if (_imagePath != null) {
      return Image.file(
        File(_imagePath),
        height: 150,
      );
    } else {
      return GestureDetector(
        child: Image.asset(
          "assets/images/camera.png",
          height: 150,
        ),
        onTap: () {
          print('Tirar foto !');
          tirarFoto();
        },
      );
    }
  }

/*
CachedNetworkImage(
            imageUrl: carro.urlFoto,
          )*/
  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipyInt,
        ),
        const Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipyInt,
        ),
        const Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipyInt,
        ),
        const Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipyInt(var newValue) {
    setState(
      () {
        _radioIndex = newValue;
      },
    );
  }

  int getTipoInt(Carros carro) {
    switch (carro.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSalvar() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (!_formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );
      return;
    }

    // Cria o carro
    var c = carro;
    c!.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");
    ApisResponse<bool> response =
        CarrosApi.save(c, _imagePath) as ApisResponse<bool>;
    if (response.ok) {
      alert(
        context,
        "Carro salvo !",
        callback: () {
          Navigator.pop(context);
        },
      );
    } else {
      print('ERRORR');
      alert(context, response.msg);
    }
    setState(
      () {
        _showProgress = false;
      },
    );

    print("Fim.");
  }

  void tirarFoto() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _file = image;
        _imagePath = image.path;
      });
      // UploadApi.upload(File(_imagePath));
    }
  }
}
