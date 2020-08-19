class Corredor {
  int cc;
  String nc;

  Corredor.fromJson(Map<String, dynamic> json) {
    cc = json['cc'];
    nc = json['nc'];
  }

  @override
  String toString() {
    return 'Corredor{cc: $cc, nc: $nc}';
  }
}
