import 'package:estagio_aiko/modelos/posicao_linha.dart';

class Linha {
  int cl;
  bool lc;
  String lt;
  int tl;
  int sl;
  String tp;
  String ts;
  String lt0;
  String lt1;
  int qv;
  List<PosicaoLinha> veiculos = [];

  Linha.fromJson(Map<String, dynamic> json) {
    cl = json['cl'];
    lc = json['lc'];
    lt = json['lt'];
    tl = json['tl'];
    sl = json['sl'];
    tp = json['tp'];
    ts = json['ts'];
  }

  Linha.fromPrevisaoJson(Map<String, dynamic> json) {
    cl = json['cl'];
    lc = json['lc'];
    sl = json['sl'];
    lt0 = json['lt0'];
    lt1 = json['lt1'];
    qv = json['qv'];
    json['vs'].forEach((e) {
      veiculos.add(PosicaoLinha.fromJson(e));
    });
  }

  String getSentido() {
    if (sl == 1) {
      return "Terminal Principal para Terminal Secundário";
    } else {
      return "Terminal Secundário para Terminal Principal";
    }
  }

  @override
  String toString() {
    return 'Linha{cl: $cl, lc: $lc, lt: $lt, tl: $tl, sl: $sl, tp: $tp, ts: $ts, lt0: $lt0, lt1: $lt1, qv: $qv, veiculos: $veiculos}';
  }
}
