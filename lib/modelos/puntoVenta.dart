import 'package:cloud_firestore/cloud_firestore.dart';

class PuntoVenta {
  String nombre;
  String codigo;
  String calle;
  String documentID;
  double latitud;
  double longitud;

  PuntoVenta(this.nombre, this.codigo, this.calle, this.documentID,
      this.latitud, this.longitud);

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'codigo': codigo,
        'calle': calle,
        'latitud': latitud,
        'longitud': longitud
      };

  PuntoVenta.fromSnapshot(DocumentSnapshot snapshot)
      : nombre = snapshot['nombre'],
        codigo = snapshot['codigo'],
        calle = snapshot['calle'],
        latitud = snapshot['latitud'],
        longitud = snapshot['longitud'],
        documentID = snapshot.id;
}
