class PosicaoLinha {
  int p;
  bool a;
  String ta;
  double py;
  double px;
  String t;

  PosicaoLinha.fromJson(Map<String, dynamic> json) {
    p = int.parse(json['p']);
    a = json['a'];
    ta = json['ta'];
    py = (json['py'] as num).toDouble();
    px = (json['px'] as num).toDouble();
    if (json['t'] != null) {
      t = json['t'];
    }
  }

  @override
  String toString() {
    return 'PosicaoLinha{p: $p, a: $a, ta: $ta, py: $py, px: $px}';
  }
}
