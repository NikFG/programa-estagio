import 'package:estagio_aiko/modelos/linha.dart';
import 'package:estagio_aiko/telas/parada_filtro_tela.dart';
import 'package:estagio_aiko/widgets/maps_linha.dart';
import 'package:flutter/material.dart';

class LinhaTile extends StatelessWidget {
  final Linha linha;

  LinhaTile(this.linha);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Deseja ver as paradas desta linha?"),
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
                                    isLinha: true,
                                    codigo: linha.cl,
                                    descricao: '${linha.lt} - ${linha.tl}',
                                  )));
                        },
                        child: Text("Sim"),
                      )
                    ],
                  ));
        },
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MapsLinha(
                    linha: linha.lt,
                    codigoLinha: linha.cl,
                  )));
        },
        title: Text(linha.tp),
        subtitle: Text(linha.getSentido()),
        leading: Text("${linha.lt} - ${linha.tl}"),
        trailing: Column(
          children: [
            Text("Circular: "),
            linha.lc
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.close,
                    color: Colors.red,
                  )
          ],
        ),
      ),
    );
  }
}
