import 'package:app_prueba/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatelessWidget {
  final dynamic latitud;
  final dynamic longitud;
  const GoogleMaps({
    Key key,
    this.latitud,
    this.longitud,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Titulo2(
            text1: "Mapa",
          ),
        ),
        backgroundColor: Color(0xFF21BFBD),
        body: Container(
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
          ),
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(latitud, longitud), zoom: 16),
            compassEnabled: false,
            markers: _createMarkers(),
            scrollGesturesEnabled: true,
          ),
        ));
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
        markerId: MarkerId("Point"), position: LatLng(latitud, longitud)));
    return tmp;
  }
}
