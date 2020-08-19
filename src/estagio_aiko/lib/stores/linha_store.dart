import 'package:estagio_aiko/controle/util_shared_preferences.dart';
import 'package:estagio_aiko/modelos/linha.dart';
import 'package:mobx/mobx.dart';

part 'linha_store.g.dart';

class LinhaStore = _LinhaStore with _$LinhaStore;

abstract class _LinhaStore with Store {
  @observable
  String filtro = '';

  @observable
  String result = '';

  @observable
  ObservableList<Linha> lista = ObservableList<Linha>();

  @action
  void filtraDados(List<Linha> lista) {
    this.lista = ObservableList.of(lista
        .where((element) =>
            element.tp.toLowerCase().contains(filtro.toLowerCase()))
        .toList());
  }

  @action
  getBanco() async {
    result = await UtilSharedPreferences.getPesquisaLinha();
  }

  @computed
  bool get isResultEmpty => result.isEmpty && result != null;

  @computed
  bool get isFiltroEmpty => filtro.isEmpty;
}
