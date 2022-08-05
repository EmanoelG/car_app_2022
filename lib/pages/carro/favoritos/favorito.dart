import '../../../util/sql/entity.dart';
import '../carro.dart';

class Favorito extends Entity {
  late int id;
  late String name;
  Favorito.fromCarro(Carros c) {
    id = c.id;
    name = c.nome;
  }
  Favorito.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
  }
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.name;
    return data;
  }
}
