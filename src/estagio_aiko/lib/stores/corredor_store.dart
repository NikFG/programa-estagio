import 'package:estagio_aiko/modelos/corredor.dart';
import 'package:mobx/mobx.dart';

part 'corredor_store.g.dart';

class CorredorStore = _CorredorStore with _$CorredorStore;

abstract class _CorredorStore with Store {
  @observable
  String filtro = '';

  @observable
  ObservableList<Corredor> lista = ObservableList<Corredor>();

  @computed
  bool get isCodigo => _isNumero();

  @action
  List<Corredor> filtraDados() {
    if (_isNumero()) {
      return lista.where((element) => element.cc == int.parse(filtro)).toList();
    }
    return lista
        .where((element) =>
            element.nc.toLowerCase().contains(filtro.toLowerCase()))
        .toList();
  }

  bool _isNumero() {
    if (filtro == null) {
      return false;
    }
    return double.parse(filtro, (e) => null) != null;
  }
}
