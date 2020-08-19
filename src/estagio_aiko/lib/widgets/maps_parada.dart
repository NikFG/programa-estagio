import 'package:estagio_aiko/modelos/parada.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:estagio_aiko/controle/api.dart';

class MapsParada extends StatefulWidget {
  final List<Parada> paradas;

  MapsParada({@required this.paradas});

  @override
  _MapsParadaState createState() => _MapsParadaState();
}

class _MapsParadaState extends State<MapsParada> {
  Api api = Api();
  GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final latLngSP = LatLng(-23.6815315, -46.8754886);
  var key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Paradas'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          GoogleMap(
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              mapController = controller;
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: latLngSP, zoom: 10)));
              widget.paradas.forEach((element) {
                setState(() {
                  _markers.add(marker(LatLng(element.py,element.px),element.np));
                });
              });
            },
            initialCameraPosition: CameraPosition(target: latLngSP, zoom: 1),
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
                'Última atualização às ${horarioAtual()}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  marker(LatLng latLng, String nomeParada) {
    return Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        onTap: () {
          key.currentState.showSnackBar(SnackBar(
            content: Text('$nomeParada\nLatitude: ${latLng.latitude.toString()}\nLongitude: ${latLng.longitude.toString()}'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
          ));
        });
  }

  String horarioAtual() {
    var timeFormat = DateFormat("HH:mm");
    var data = DateTime.now();
    return timeFormat.format(data);
  }
}
