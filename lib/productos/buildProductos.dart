import 'package:app_prueba/productos/addYedit_view.dart';
import 'package:app_prueba/modelos/producto.dart';
import 'package:app_prueba/modelos/puntoVenta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildProdCardProd extends StatelessWidget {
  final BuildContext contexts;
  final DocumentSnapshot documents;
  final String ids;

  const BuildProdCardProd({Key key, this.contexts, this.documents, this.ids})
      : super(key: key);
  @override

  //LISTA de Productos
  Widget build(context) {
    final producto = Producto.fromSnapshot(documents);
    return Container(
        height: 120,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: Row(
                    children: [
                      subtitulos(),
                      SizedBox(width: 10.0),
                      Column(children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              productos("${producto.nombre}"),
                              SizedBox(height: 9),
                              productos("${producto.preciocosto}"),
                              SizedBox(height: 9),
                              productos("${producto.preciomayor}"),
                              SizedBox(height: 9),
                              productos("${producto.stock}")
                            ],
                          ),
                        ),
                      ]),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () {
                          Navigator.push(
                              contexts,
                              MaterialPageRoute(
                                  builder: (contexts) => AddYEditView(
                                        productoEdit: producto,
                                        idPuntoVenta: ids,
                                      )));
                        },
                      )
                    ],
                  ),
                )
              ]),
        ));
  }

  IconButton buildIconButton(Icon icono, Widget widget) {
    return IconButton(
      icon: icono,
      onPressed: () {
        Navigator.push(
            contexts, MaterialPageRoute(builder: (contexts) => widget));
      },
    );
  }

  Text productos(String producto) {
    return Text(
      producto.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 15.0,
        color: Colors.black,
      ),
    );
  }

  Widget subtitulos() {
    return Column(
      children: [
        Container(
          width: 80,
          padding: EdgeInsets.only(top: 5, bottom: 4, left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Productos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("P.Costo", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("P.R. Mayor", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 11),
              Text("Stock", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Container nombre(PuntoVenta puntoVenta) {
    return Container(
        width: 100,
        child: Hero(
          tag: puntoVenta.documentID, //TAG a enviar
          child: Text(
            puntoVenta.nombre,
            style: TextStyle(
              fontFamily: 'Montserrat', //Cambiar font
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ));
  }
}
