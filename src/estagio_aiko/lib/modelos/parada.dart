class Parada {
  int cp;
  String np;
  String ed;
  double py;
  double px;


  Parada(int cp, double py, double px) {
    this.cp = cp;
    this.py = py;
    this.px = px;
  }

  Parada.fromJson(Map<String, dynamic> json) {
    cp = json['cp'];
    np = json['np'];
    ed = json['ed'];
    py = (json['py'] as num).toDouble();
    px = (json['px'] as num).toDouble();
  }
}
