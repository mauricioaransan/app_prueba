import 'package:app_prueba/punto_venta/maps.dart';
import 'package:app_prueba/modelos/puntoVenta.dart';
import 'package:app_prueba/punto_venta/visita.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BuildProdCard extends StatelessWidget {
  final BuildContext contexts;
  final DocumentSnapshot documents;

  const BuildProdCard({Key key, this.contexts, this.documents})
      : super(key: key);
  @override

  //LISTA de Productos
  Widget build(context) {
    final puntoVenta = PuntoVenta.fromSnapshot(documents);
    timeDilation = 2.0; //tiempo de animación del HERO
    return Container(
        height: 120,
        child: Card(
          //DECORAR EL CARD
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  child: Row(
                    children: [
                      InkWell(
                        child: image(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMaps(
                                        latitud: puntoVenta.latitud,
                                        longitud: puntoVenta.longitud,
                                      )));
                        },
                      ),
                      SizedBox(width: 10.0),
                      Column(children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              puntoDeVenta("${puntoVenta.nombre}"),
                              SizedBox(height: 9),
                              puntoDeVenta("Calle: ${puntoVenta.calle}"),
                              SizedBox(height: 9),
                              puntoDeVenta("Codigo: ${puntoVenta.codigo}")
                            ],
                          ),
                        ),
                      ]),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () {
                          _mostrarAlerta(context);
                        },
                      )

                      // AddYEditView(productoEdit: productos,)),
                      // buildIconButton(Icon(Icons.article_outlined,color: Colors.blueGrey),
                      //       DetailYReportView(productoDetailReport:  productos, decision: false,)),
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

  Text puntoDeVenta(String puntoVenta) {
    return Text(
      puntoVenta,
      style: TextStyle(
        fontFamily: 'Montserrat', //Cambiar font
        fontSize: 15.0,
        color: Colors.black,
      ),
    );
  }

  Container image() {
    return Container(child: Text("Sexo"));
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

  void _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text("titulo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("El contenido de la alerta"),
                FlutterLogo(
                  size: 15.0,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Visita()));
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }
}
