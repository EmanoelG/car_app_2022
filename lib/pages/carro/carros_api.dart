import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../login/usuario.dart';
import 'carro.dart';
import 'favoritos/carro_dao.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carros>> getCarros(String tipoCarro) async {
    // String s = tipoCarro.toString().replaceAll('TipoCarro.', "");
    try {
      var url =
          'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipoCarro';
      print(url);
      Usuario user = await Usuario.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}",
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      print('status > ${response.statusCode}');
      String json = response.body;
      print('json > $json');
      List list = convert.json.decode(json);
      List<Carros> carros =
          list.map<Carros>((e) => Carros.fromJson(e)).toList();
      final dao = CarroDAO();
      carros.forEach(
        (c) {
          dao.save(c);
        },
      );

      return list.map<Carros>((e) => Carros.fromJson(e)).toList();
    } on Exception catch (e) {
      print('e>> $e');
    }
  }

  static Future<ApisResponse<bool>> save(Carros c, String filePath) async {
    try {
      if (filePath != null) {
        final response = await UploadApi.upload(File(filePath));
        if (response.ok) {
          print('');
          print('Response Ok');
          print('');
          String urlFoto = response.result;
          c.urlFoto = urlFoto;
        }
      }
      Usuario user = await Usuario.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}",
      };
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (c.id != null) {
        url += '/${c.id}';
      }
      print("Post > " + url);

      String json = c.toJson();
      var response = await (c.id == null
          ? http.post(Uri.parse(url), body: json, headers: headers)
          : http.put(Uri.parse(url), body: json, headers: headers));
      print("STATUS CODE: " + response.statusCode.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        Map mapResponse = convert.json.decode(response.body);
        Carros car = Carros.fromJson(mapResponse);
        print('Novo carros: ${car.id}');
        return ApisResponse.ok(true);
      }
      if (response.body == null || response.body.isEmpty) {
        Map mapResponse = convert.json.decode(response.body);
        return ApisResponse.error(
            mapResponse["Não foi possível salvar o carro !"]);
      }
      Map mapResponse = convert.json.decode(response.body);
      return ApisResponse.error(mapResponse["error"]);
    } on Exception catch (e) {
      return ApisResponse.error("Não foi possível salvar o carro !");
    }
  }

  static delete(c) async {
    try {
      Usuario user = await Usuario.get();
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}",
      };
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${c.id}';

      print("delete > " + url);

      String json = c.toJson();
      var response = await http.delete(Uri.parse(url), headers: headers);

      print("STATUS CODE: " + response.statusCode.toString());
      if (response.statusCode == 201 || response.statusCode == 200) {
        Map mapResponse = convert.json.decode(response.body);
        Carros car = Carros.fromJson(mapResponse);
        print('Novo carros: ${car.id}');
        return ApisResponse.ok(true);
      }
      if (response.body == null || response.body.isEmpty) {
        Map mapResponse = convert.json.decode(response.body);
        return ApisResponse.error(
            mapResponse["Não foi possível deletar o carro !"]);
      }
      Map mapResponse = convert.json.decode(response.body);
      return ApisResponse.error(mapResponse["error"]);
    } on Exception catch (e) {
      return ApisResponse.error("Não foi possível deletar o carro !");
    }
  }
}
