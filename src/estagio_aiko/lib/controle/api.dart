import 'package:http/http.dart' as http;

class Api {
  static const _url = 'http://api.olhovivo.sptrans.com.br/v2.1';
  static const _token =
      '3f07c6c2d438dc25f1ec1792c3176a33c0d56b3365167ab450ec6e233040d1b0';
  Map<String, String> headers = {};

  Api();

  Future<bool> _auth() async {
    var response = await http.post('$_url/Login/Autenticar?token=$_token');
    bool result = response.body == 'true';
    if (result) _updateCookie(response.headers['set-cookie']);
    return result;
  }

  Future<http.Response> getPosicao(int codigoLinha) async {
    await _auth();
    return http.get('$_url/Posicao/Linha?codigoLinha=${codigoLinha.toString()}',
        headers: headers);
  }

  Future<http.Response> getTodasPosicoes() async {
    await _auth();
    return http.get('$_url/Posicao}',
        headers: headers);
  }

  Future<http.Response> getPrevisaoChegada(int codigoParada) async {
    await _auth();
    return http.get(
        '$_url/Previsao/Parada?codigoParada=${codigoParada.toString()}',
        headers: headers);
  }

  Future<http.Response> getLinhas(String linha) async {
    await _auth();
    return http.get('$_url/Linha/Buscar?termosBusca=$linha', headers: headers);
  }

  Future<http.Response> getParadas(String busca) async {
    await _auth();
    return http.get('$_url/Parada/Buscar?termosBusca=$busca', headers: headers);
  }

  Future<http.Response> getParadasPorLinha(int codigoLinha) async {
    await _auth();
    return http.get(
        '$_url/Parada/BuscarParadasPorLinha?codigoLinha=${codigoLinha.toString()}',
        headers: headers);
  }

  Future<http.Response> getParadasPorCorredor(int codigoCorredor) async {
    await _auth();
    return http.get(
        '$_url/Parada/BuscarParadasPorCorredor?codigoCorredor=${codigoCorredor.toString()}',
        headers: headers);
  }

  Future<http.Response> getCorredores() async {
    await _auth();
    return http.get('$_url/Corredor', headers: headers);
  }

  void _updateCookie(String rawCookie) {
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
