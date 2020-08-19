import 'package:shared_preferences/shared_preferences.dart';

class UtilSharedPreferences {
  static SharedPreferences _prefs;

  UtilSharedPreferences();

  static _getInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<String> getPesquisaLinha() async {
    await _getInstance();
    String pesquisa = '';
    try {
      if (_prefs.containsKey('pesquisaLinha'))
        pesquisa = _prefs.getString('pesquisaLinha');
    } catch (e) {
      print(e);
    }
    return pesquisa;
  }

  static Future<bool> setPesquisaLinha(String pesquisa) async {
    await _getInstance();
    return await _prefs.setString('pesquisaLinha', pesquisa);
  }

  static Future<String> getPesquisaParada() async {
    await _getInstance();
    String pesquisa = '';
    try {
      if (_prefs.containsKey('pesquisaParada'))
        pesquisa = _prefs.getString('pesquisaParada');
    } catch (e) {
      print(e);
    }
    return pesquisa;
  }

  static Future<bool> setPesquisaParada(String pesquisa) async {
    await _getInstance();
    return await _prefs.setString('pesquisaParada', pesquisa);
  }
}
