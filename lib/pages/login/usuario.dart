import 'dart:convert' as convert;

import 'package:list_car/util/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuario(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    print('gettt !!!');
    var prefs = await SharedPreferences.getInstance();
    // prefs.
    bool contains = prefs.containsKey("user.prefs");
    print('Contain: $contains');
    if (contains == true) {
      String js = prefs.getString("user.prefs") ?? null;
      print('js:>>> ' + js);

      if (js == "") {
        return null;
      }

      Map map = convert.json.decode(js);
      Usuario user = Usuario.fromJson(map);
      print(user);
      return user;
    } else
      return null;
  }

  @override
  String toString() {
    return '<><><> Usuario{login: $login, nome: $nome,  email: $email, urlFoto: $urlFoto';
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }
}
