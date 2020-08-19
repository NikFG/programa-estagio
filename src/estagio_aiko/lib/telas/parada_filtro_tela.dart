import 'dart:convert';

import 'package:estagio_aiko/controle/api.dart';
import 'package:estagio_aiko/modelos/parada.dart';
import 'package:estagio_aiko/tiles/parada_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParadaFiltroTela extends StatelessWidget {
  final bool isLinha;
  final int codigo;
  final String descricao;

  ParadaFiltroTela(
      {@required this.isLinha,
      @required this.codigo,
      @required this.descricao});

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: isLinha
            ? Text("Paradas da linha $descricao")
            : Text("Paradas do corredor $descricao"),
        centerTitle: true,
      ),
      body: FutureBuilder<http.Response>(
        future: isLinha
            ? api.getParadasPorLinha(codigo)
            : api.getParadasPorCorredor(codigo),
        builder: (context, response) {
          if (!response.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<dynamic> dados = json.decode(response.data.body);
            return ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) {
                  return ParadaTile(Parada.fromJson(dados[index]));
                });
          }
        },
      ),
    );
  }
}
