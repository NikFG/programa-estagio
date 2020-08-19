import 'dart:convert';


import 'package:estagio_aiko/controle/api.dart';
import 'package:estagio_aiko/modelos/corredor.dart';
import 'package:estagio_aiko/stores/corredor_store.dart';
import 'package:estagio_aiko/tiles/corredor_tile.dart';
import 'package:estagio_aiko/widgets/custom_bottom_bar.dart';
import 'package:estagio_aiko/widgets/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

class CorredorTela extends StatefulWidget {
  final PageController pageController;
  final int index;

  CorredorTela(this.index, this.pageController);

  @override
  _CorredorTelaState createState() => _CorredorTelaState();
}

class _CorredorTelaState extends State<CorredorTela>
    with AutomaticKeepAliveClientMixin<CorredorTela> {
  CorredorStore store = CorredorStore();
  Api api = Api();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Corredores"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              store.filtro = '';
            },
            tooltip: "Recarregar página",
          ),
          IconButton(
            onPressed: () async {
              store.filtro = await showSearch(
                  context: context,
                  delegate: CustomSearch('Filtrar corredores'));
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomBar(widget.index, widget.pageController),
      body: Observer(
        builder: (context) {
          if (store.filtro.isNotEmpty) {
            List<Corredor> lista = store.filtraDados();
            if (lista.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Text("Não há dados para o filtro"),
              );
            }
            return ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return CorredorTile(lista[index]);
                });
          }
          return FutureBuilder<http.Response>(
            future: api.getCorredores(),
            builder: (context, response) {
              if (!response.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<dynamic> dados = json.decode(response.data.body);
                store.lista = ObservableList.of(
                    dados.map((e) => Corredor.fromJson(e)).toList());
                store.lista.sort((a, b) => a.cc.compareTo(b.cc));
                return ListView.builder(
                    itemCount: dados.length,
                    itemBuilder: (context, index) {
                      return CorredorTile(store.lista[index]);
                    });
              }
            },
          );
        },
      ),
    );
  }
}
