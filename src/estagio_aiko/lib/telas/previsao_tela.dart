import 'dart:convert';

import 'package:estagio_aiko/controle/api.dart';
import 'package:estagio_aiko/modelos/previsao_chegada.dart';
import 'package:estagio_aiko/tiles/previsao_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrevisaoTela extends StatelessWidget {
  final int codigoParada;

  PrevisaoTela(this.codigoParada);

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return Scaffold(
      appBar: AppBar(
        title: Text("Previsão de chegada"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<http.Response>(
        future: api.getPrevisaoChegada(codigoParada),
        builder: (context, response) {
          if (!response.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Map<String, dynamic> dados = json.decode(response.data.body);
            var p = PrevisaoChegada.fromJson(dados);


              return ListView.builder(
                itemCount: p.linhas.length,
                itemBuilder: (context, index) {
                  return PrevisaoTile(p,index);
                });
          }
        },
      ),
    );
  }
}
