import 'dart:convert';
import 'package:estagio_aiko/modelos/parada.dart';
import 'package:estagio_aiko/modelos/posicao_linha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:estagio_aiko/controle/api.dart';

const MAPS_API_KEY = 'AIzaSyBMdm2FQmsLAsf-Qy_Njj9fcQJO9YSZD4c';

class RotaLinhaTela extends StatefulWidget {
  final int codigoLinha;
  final String linha;
  final Parada parada;

  RotaLinhaTela(
      {@required this.codigoLinha,
      @required this.linha,
      @required this.parada});

  @override
  _RotaLinhaTelaState createState() => _RotaLinhaTelaState();
}

class _RotaLinhaTelaState extends State<RotaLinhaTela> {
  Api api = Api();
  GoogleMapController mapController;
  final Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  List<LatLng> coordenadasRotas = [];

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
            PosicaoLinha posicaoLinha =
                PosicaoLinha.fromJson(dados['vs'].first);

            LatLng latLng = LatLng(posicaoLinha.py, posicaoLinha.px);
            getRota(
                latLng, LatLng(widget.parada.py, widget.parada.px));
            return Stack(
              fit: StackFit.loose,
              children: [
                GoogleMap(
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) {
                    mapController = controller;
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: latLng, zoom: 12)));
                    setState(() {
                      _markers.add(marker(latLng));
                      _markers.add(
                          marker(LatLng(widget.parada.py, widget.parada.px)));
                    });
                  },
                  initialCameraPosition:
                      CameraPosition(target: latLng, zoom: 1),
                  mapType: MapType.normal,
                  markers: _markers,
                  polylines: _polyline,
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

  getRota(LatLng l1, LatLng l2) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> result = await polylinePoints
        .getRouteBetweenCoordinates(
            MAPS_API_KEY, l1.latitude, l1.longitude, l2.latitude, l2.longitude)
        .then((value) =>
            value.map((e) => LatLng(e.latitude, e.longitude)).toList());
    _polyline.add(Polyline(
        polylineId: PolylineId('rota'),
        width: 4,
        points: result,
        color: Colors.blue));
  }

  ///Processo manual
/*    String url = "https://maps.googleapis.com/maps/api/directions/json?origin="
      "${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
   http.Response response = await http.get(url);
   Map values = jsonDecode(response.body);
    String route = values["routes"][0]["overview_polyline"]["points"];

    createRoute(route);

  void createRoute(String encondedPoly) {
    _polyline.add(Polyline(
        polylineId: PolylineId('route'),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (int i = 2; i < lList.length; i++) {
      lList[i] += lList[i - 2];
    }
    return lList;
  }*/
}
