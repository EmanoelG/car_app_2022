// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'carros_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************
// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic
mixin _$ModelCar on CarrosModel, Store {
  final _$carrosAtom = Atom(name: 'CarrosModel.carros');

  @override
  List<Carros> get carros {
    _$carrosAtom.reportRead();
    return super.carros;
  }

  @override
  set carros(List<Carros> value) {
    _$carrosAtom.reportWrite(value, super.carros, () {
      super.carros = value;
    });
  }

  final _$errorAtom = Atom(name: 'CarrosModel.error');

  @override
  Exception get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('CarrosModel.fetch');

  @override
  Future fetch(String tipoCarro) {
    return _$fetchAsyncAction.run(() => super.fetch(tipoCarro));
  }

  @override
  String toString() {
    return '''
carros: ${carros},
error: ${error}
    ''';
  }
}
