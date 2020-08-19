import 'dart:convert';
import 'package:estagio_aiko/controle/util_shared_preferences.dart';
import 'package:estagio_aiko/modelos/parada.dart';
import 'package:estagio_aiko/stores/parada_store.dart';
import 'package:estagio_aiko/tiles/parada_tile.dart';
import 'package:estagio_aiko/widgets/custom_bottom_bar.dart';
import 'package:estagio_aiko/widgets/custom_text_field.dart';
import 'package:estagio_aiko/widgets/maps_parada.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http;
import 'package:estagio_aiko/controle/api.dart';
import '../widgets/custom_search.dart';

class ParadaTela extends StatefulWidget {
  final int index;
  final PageController pageController;

  ParadaTela(this.index, this.pageController);

  @override
  _ParadaTelaState createState() => _ParadaTelaState();
}

class _ParadaTelaState extends State<ParadaTela>{
//    with AutomaticKeepAliveClientMixin<ParadaTela> {
  ParadaStore store = ParadaStore();
  List<Parada> paradas = [];

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
            icon: Icon(Icons.map),
            onPressed: () async {
              List<dynamic> dados = await json
                  .decode(await api.getParadas('').then((value) => value.body));
              List<Parada> paradas = dados.map((element) {
                return Parada.fromJson(element);
              }).toList();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapsParada(paradas: paradas)));
            },
            tooltip: 'Mostrar paradas no mapa',
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              store.filtro = '';
              store.result = '';
              FocusScope.of(context).unfocus();
            },
            tooltip: "Recarregar página",
          ),
          IconButton(
            onPressed: () async {
              store.result = await showSearch(
                  context: context, delegate: CustomSearch('Procurar paradas'));
              await UtilSharedPreferences.setPesquisaParada(store.result);
            },
            icon: Icon(Icons.search),
          )
        ],
        title: Text("Paradas"),
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
                  hint: "Filtre por nome",
                  onChanged: (value) {
                    store.filtro = value;
                    store.filtraDados(paradas);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (context) {
                    if (store.isFiltroEmpty) {
                      return FutureBuilder<http.Response>(
                        future: api.getParadas(store.result),
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
                            paradas =
                                dados.map((e) => Parada.fromJson(e)).toList();
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: paradas.length,
                                itemBuilder: (context, index) {
                                  return ParadaTile(paradas[index]);
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
                                return ParadaTile(store.lista[index]);
                              })
                          : Center(
                              child: Text("Não há resultados para o filtro"));
                    }
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}
