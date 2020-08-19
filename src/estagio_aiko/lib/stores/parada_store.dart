import 'package:estagio_aiko/controle/util_shared_preferences.dart';
import 'package:estagio_aiko/modelos/parada.dart';
import 'package:mobx/mobx.dart';

part 'parada_store.g.dart';

class ParadaStore = _ParadaStore with _$ParadaStore;

abstract class _ParadaStore with Store {
  @observable
  String filtro = '';

  @observable
  String result = '';

  @observable
  ObservableList<Parada> lista = ObservableList<Parada>();
  @action
  void filtraDados(List<Parada> lista) {
    this.lista = ObservableList.of(lista
        .where((element) =>
        element.np.toLowerCase().contains(filtro.toLowerCase()))
        .toList());
  }
  @action
  getBanco() async {
    result = await UtilSharedPreferences.getPesquisaParada();
  }
  @computed
  bool get isResultEmpty => result.isEmpty && result != null;

  @computed
  bool get isFiltroEmpty => filtro.isEmpty;
}
