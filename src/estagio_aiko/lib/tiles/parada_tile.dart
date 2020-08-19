import 'package:estagio_aiko/modelos/parada.dart';
import 'package:estagio_aiko/telas/previsao_tela.dart';
import 'package:estagio_aiko/telas/rota_pessoa_parada_tela.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParadaTile extends StatelessWidget {
  final Parada parada;

  ParadaTile(this.parada);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Deseja exibir no mapa essa parada?"),
                    actions: [
                      FlatButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text("Não"),
                      ),
                      FlatButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RotaPessoaParadaTela(
                                    latLngParada: LatLng(parada.py, parada.px),
                                    nomeParada: parada.np,
//                              MapsParada(
//                            latLng: LatLng(parada.py, parada.px),
//                            parada: parada.np,
                                  )));
                        },
                        child: Text("Sim"),
                      ),
                    ],
                  ));
        },
        onTap: () async {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PrevisaoTela(parada.cp)));
        },
        title: Text(this.parada.np),
        subtitle: Text(this.parada.ed),
        trailing: null,
      ),
    );
  }
}
