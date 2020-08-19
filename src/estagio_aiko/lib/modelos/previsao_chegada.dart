import 'package:estagio_aiko/modelos/linha.dart';

class PrevisaoChegada {
  String hr;
  int cp;
  String np;
  double py;
  double px;
  List<Linha> linhas = [];

  PrevisaoChegada.fromJson(Map<String, dynamic> json) {
    hr = json['hr'];
    cp = json['p']['cp'];
    np = json['p']['np'];
    py = json['p']['py'];
    px = json['p']['px'];
    json['p']['l'].forEach((e) {
      linhas.add(Linha.fromPrevisaoJson(e));
    });
  }

  @override
  String toString() {
    return 'PrevisaoChegada{hr: $hr, cp: $cp, py: $py, px: $px, linhas: $linhas}';
  }
}
