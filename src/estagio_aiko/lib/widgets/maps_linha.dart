import 'dart:convert';
import 'package:estagio_aiko/modelos/posicao_linha.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:estagio_aiko/controle/api.dart';

class MapsLinha extends StatefulWidget {
  final int codigoLinha;
  final String linha;

  MapsLinha({@required this.codigoLinha, @required this.linha});

  @override
  _MapsLinhaState createState() => _MapsLinhaState();
}

class _MapsLinhaState extends State<MapsLinha> {
  Api api = Api();
  GoogleMapController mapController;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Resultados para linha ${widget.linha}'),
        centerTitle: true,
      ),
      body: FutureBuilder<http.Response>(
        future: api.getPosicao(widget.codigoLinha),
        builder: (context, response) {
          if (!response.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var dados = json.decode(response.data.body);
            if (dados['vs'].isEmpty) {
              return Container();
            }
            String hr = dados['hr'];
            print(dados['vs']);
            List<LatLng> latLng = [];
            dados['vs'].forEach((e) {
              PosicaoLinha posicaoLinha = PosicaoLinha.fromJson(e);
              latLng.add(LatLng(posicaoLinha.py, posicaoLinha.px));
            });

            return Stack(
              fit: StackFit.loose,
              children: [
                GoogleMap(
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) {
                    mapController = controller;
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: latLng.first, zoom: 12)));
                    latLng.forEach((e) {
                      setState(() {
                        _markers.add(marker(e));
                      });
                    });
                  },
                  initialCameraPosition:
                      CameraPosition(target: latLng.first, zoom: 1),
                  mapType: MapType.normal,
                  markers: _markers,
                ),
                Positioned(
                  top: 10,
                  left: 15,
                  right: 15,
                  child: Container(
                    color: Colors.white,
                    child: Text(
                      'Última atualização às $hr',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  marker(LatLng latLng) {
    return Marker(markerId: MarkerId(latLng.toString()), position: latLng);
  }
}
