import 'dart:convert';
import 'package:estagio_aiko/controle/util_shared_preferences.dart';
import 'package:estagio_aiko/modelos/linha.dart';
import 'package:estagio_aiko/stores/linha_store.dart';
import 'package:estagio_aiko/tiles/linha_tile.dart';
import 'package:estagio_aiko/widgets/custom_bottom_bar.dart';
import 'package:estagio_aiko/widgets/custom_search.dart';
import 'package:estagio_aiko/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:estagio_aiko/controle/api.dart';

class LinhaTela extends StatefulWidget {
  final int index;
  final PageController pageController;

  LinhaTela(this.index, this.pageController);

  @override
  _LinhaTelaState createState() => _LinhaTelaState();
}

class _LinhaTelaState extends State<LinhaTela> {
  LinhaStore store = LinhaStore();
  List<Linha> linhas = [];


  @override
  void initState() {
    super.initState();
    store.getBanco();

  }

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              store.filtro = '';
              store.result = '';
              UtilSharedPreferences.setPesquisaLinha('');
              FocusScope.of(context).unfocus();
            },
            tooltip: "Recarregar página",
          ),
          IconButton(
            onPressed: () async {
              store.result = await showSearch(
                  context: context, delegate: CustomSearch('Procurar linhas'));
              await UtilSharedPreferences.setPesquisaLinha(store.result);
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text("Linhas"),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomBar(widget.index, widget.pageController),
      body: Observer(
        builder: (context) {
          if (store.isResultEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text("Pesquise acima os dados"),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Resultados para ${store.result}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  enabled: !store.isResultEmpty,
                  hint: "Filtre por letreiro",
                  onChanged: (value) {
                    store.filtro = value;
                    store.filtraDados(linhas);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (context) {
                    if (store.isFiltroEmpty) {
                      return FutureBuilder<http.Response>(
                        future: api.getLinhas(store.result),
                        builder: (context, response) {
                          if (!response.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            List<dynamic> dados =
                                json.decode(response.data.body);
                            if (dados.isEmpty) {
                              return Center(
                                  child: Text(
                                      "Não há resultados para a pesquisa"));
                            }
                            linhas =
                                dados.map((e) => Linha.fromJson(e)).toList();

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: linhas.length,
                                itemBuilder: (context, index) {
                                  return LinhaTile(linhas[index]);
                                });
                          }
                        },
                      );
                    } else {
                      return store.lista.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: store.lista.length,
                              itemBuilder: (context, index) {
                                return LinhaTile(store.lista[index]);
                              })
                          : Center(
                              child: Text("Não há resultados para o filtro"));
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }


}
