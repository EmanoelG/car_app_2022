import 'dart:convert' as convert;

import '../../util/sql/entity.dart';

class Carros extends Entity {
  late int id;
  late String nome;
  late String tipo;
  late String descricao;
  late String urlFoto;
  late String urlVideo;
  late String latitude;
  late String longitude;

  int get getId => id;
  set setId(int id) => id = id;
  String get _nome => nome;
  set setNome(String nome) => nome = nome;
  String get getTipo => tipo;
  set setTipo(String tipo) => tipo = tipo;
  String get getDescricao => descricao;
  set setDescricao(String descricao) => descricao = descricao;
  String get geturlFoto => urlFoto;
  set setUrlFoto(String urlFoto) => urlFoto = urlFoto;
  String get getUrlVideo => urlVideo;
  set setUrlVideo(String urlVideo) => urlVideo = urlVideo;
  String get getlatitude => latitude;
  set setLatitude(String latitude) => latitude = latitude;
  String get getLongitude => longitude;
  set setLongitude(String longitude) => longitude = longitude;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['nome'] = nome;
    data['tipo'] = tipo;
    data['descricao'] = descricao;
    data['urlFoto'] = urlFoto;
    data['urlVideo'] = urlVideo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

   Carros.fromJson(Map<String, dynamic> json) {
        id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    descricao = json['descricao'];
    urlFoto = json['urlFoto'];
    urlVideo = json['urlVideo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}
