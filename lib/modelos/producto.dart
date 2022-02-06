import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  String nombre;
  double preciocosto;
  double preciomayor;
  int stock;
  String documentID;

  Producto(this.nombre, this.preciocosto, this.preciomayor, this.stock,
      this.documentID);

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'preciocosto': preciocosto,
        'preciomayor': preciomayor,
        'stock': stock,
      };

  Producto.fromSnapshot(DocumentSnapshot snapshot)
      : nombre = snapshot['nombre'],
        preciocosto = snapshot['preciocosto'],
        preciomayor = snapshot['preciomayor'],
        stock = snapshot['stock'],
        documentID = snapshot.id;
}
