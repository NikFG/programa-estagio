// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corredor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CorredorStore on _CorredorStore, Store {
  Computed<bool> _$isCodigoComputed;

  @override
  bool get isCodigo => (_$isCodigoComputed ??=
          Computed<bool>(() => super.isCodigo, name: '_CorredorStore.isCodigo'))
      .value;

  final _$filtroAtom = Atom(name: '_CorredorStore.filtro');

  @override
  String get filtro {
    _$filtroAtom.reportRead();
    return super.filtro;
  }

  @override
  set filtro(String value) {
    _$filtroAtom.reportWrite(value, super.filtro, () {
      super.filtro = value;
    });
  }

  final _$listaAtom = Atom(name: '_CorredorStore.lista');

  @override
  ObservableList<Corredor> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Corredor> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  final _$_CorredorStoreActionController =
      ActionController(name: '_CorredorStore');

  @override
  List<Corredor> filtraDados() {
    final _$actionInfo = _$_CorredorStoreActionController.startAction(
        name: '_CorredorStore.filtraDados');
    try {
      return super.filtraDados();
    } finally {
      _$_CorredorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtro: ${filtro},
lista: ${lista},
isCodigo: ${isCodigo}
    ''';
  }
}
