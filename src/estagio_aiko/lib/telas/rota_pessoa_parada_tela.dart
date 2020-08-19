import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

const MAPS_API_KEY = 'AIzaSyBMdm2FQmsLAsf-Qy_Njj9fcQJO9YSZD4c';

class RotaPessoaParadaTela extends StatefulWidget {
  final LatLng latLngParada;
  final String nomeParada;

  RotaPessoaParadaTela(
      {@required this.latLngParada, @required this.nomeParada});

  @override
  _RotaPessoaParadaTelaState createState() => _RotaPessoaParadaTelaState();
}

class _RotaPessoaParadaTelaState extends State<RotaPessoaParadaTela> {
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
        title: Text('${widget.nomeParada}'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          GoogleMap(
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) async {
              final status = await (Permission.location).request();
              LatLng latLngPessoa = LatLng(-23.6815315, -46.8754886);
              if (status.isGranted) {
                latLngPessoa = await Geolocator()
                    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                    .then((value) => LatLng(value.latitude, value.longitude));
              }
              await getRota(widget.latLngParada, latLngPessoa);
              mapController = controller;
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: widget.latLngParada, zoom: 11)));
              Marker paradaMarker =
                  await (marker(widget.latLngParada, 'assets/markers/bus.png'));
              Marker pessoaMarker =
                  await (marker(latLngPessoa, 'assets/markers/person.png'));
              setState(() {
                _markers.add(paradaMarker);
                _markers.add(pessoaMarker);
              });
            },
            initialCameraPosition:
                CameraPosition(target: widget.latLngParada, zoom: 1),
            mapType: MapType.normal,
            markers: _markers,
            polylines: _polyline,
          ),
        ],
      ),
    );
  }

  marker(LatLng latLng, String asset) async {
    final Uint8List markerIcon = await getBytesFromAsset(asset, 200);
    return Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      draggable: false,
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
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
}
