import 'package:estagio_aiko/modelos/corredor.dart';
import 'package:estagio_aiko/telas/parada_filtro_tela.dart';
import 'package:flutter/material.dart';

class CorredorTile extends StatelessWidget {
  final Corredor corredor;

  CorredorTile(this.corredor);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Deseja ver as paradas deste corredor?"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Não"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ParadaFiltroTela(
                            isLinha: false,
                            codigo: corredor.cc,
                            descricao: '${corredor.nc}',
                          )));
                    },
                    child: Text("Sim"),
                  )
                ],
              ));
        },
        leading: Text(corredor.cc.toString()),
        title: Text(corredor.nc),
      ),
    );
  }
}
