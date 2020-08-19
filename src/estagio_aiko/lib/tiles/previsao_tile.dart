import 'package:estagio_aiko/modelos/parada.dart';
import 'package:estagio_aiko/modelos/previsao_chegada.dart';
import 'package:estagio_aiko/telas/rota_linha_tela.dart';
import 'package:flutter/material.dart';

class PrevisaoTile extends StatelessWidget {
  final PrevisaoChegada previsao;
  final int index;

  PrevisaoTile(this.previsao, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RotaLinhaTela(
                    parada: Parada(previsao.cp, previsao.py, previsao.px),
                    linha: previsao.linhas[index].cl.toString(),
                    codigoLinha: previsao.linhas[index].cl,
                  )));
        },
        contentPadding: EdgeInsets.all(2),
        visualDensity: VisualDensity.comfortable,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(previsao.linhas[index].lt0),
            Text(previsao.linhas[index].lt1),
            Text(
              "Parada ${previsao.cp}",
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getVeiculos(),
        ),
      ),
    );
  }

  List<Widget> getVeiculos() {
    return previsao.linhas[index].veiculos
        .map((e) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Text('Prefixo: ${e.p.toString()}')),
                Container(
                    child: Text(
                  'Previsão: ${e.t}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 5,
                )
              ],
            ))
        .toList();
  }
}
