// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linha_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LinhaStore on _LinhaStore, Store {
  Computed<bool> _$isResultEmptyComputed;

  @override
  bool get isResultEmpty =>
      (_$isResultEmptyComputed ??= Computed<bool>(() => super.isResultEmpty,
              name: '_LinhaStore.isResultEmpty'))
          .value;
  Computed<bool> _$isFiltroEmptyComputed;

  @override
  bool get isFiltroEmpty =>
      (_$isFiltroEmptyComputed ??= Computed<bool>(() => super.isFiltroEmpty,
              name: '_LinhaStore.isFiltroEmpty'))
          .value;

  final _$filtroAtom = Atom(name: '_LinhaStore.filtro');

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

  final _$resultAtom = Atom(name: '_LinhaStore.result');

  @override
  String get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(String value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$listaAtom = Atom(name: '_LinhaStore.lista');

  @override
  ObservableList<Linha> get lista {
    _$listaAtom.reportRead();
    return super.lista;
  }

  @override
  set lista(ObservableList<Linha> value) {
    _$listaAtom.reportWrite(value, super.lista, () {
      super.lista = value;
    });
  }

  final _$getBancoAsyncAction = AsyncAction('_LinhaStore.getBanco');

  @override
  Future getBanco() {
    return _$getBancoAsyncAction.run(() => super.getBanco());
  }

  final _$_LinhaStoreActionController = ActionController(name: '_LinhaStore');

  @override
  void filtraDados(List<Linha> lista) {
    final _$actionInfo = _$_LinhaStoreActionController.startAction(
        name: '_LinhaStore.filtraDados');
    try {
      return super.filtraDados(lista);
    } finally {
      _$_LinhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtro: ${filtro},
result: ${result},
lista: ${lista},
isResultEmpty: ${isResultEmpty},
isFiltroEmpty: ${isFiltroEmpty}
    ''';
  }
}
