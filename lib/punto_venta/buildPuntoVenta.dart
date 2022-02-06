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
        height: 80,
        child: InkWell(
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
                            width: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                nombrePuntoVenta("${puntoVenta.nombre}"),
                                SizedBox(height: 9),
                                puntoDeVenta("Calle: ${puntoVenta.calle}"),
                                SizedBox(height: 7),
                                puntoDeVenta("Codigo: ${puntoVenta.codigo}")
                              ],
                            ),
                          ),
                        ]),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_right,
                            color: Colors.blueAccent,
                            size: 40,
                          ),
                          onPressed: () {
                            _mostrarAlerta(context, puntoVenta);
                          },
                        )
                      ],
                    ),
                  )
                ]),
          ),
          onTap: () {
            _mostrarAlerta(context, puntoVenta);
          },
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

  Text nombrePuntoVenta(String nombre) {
    return Text(
      nombre.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Montserrat', //Cambiar font
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Text puntoDeVenta(String puntoVenta) {
    return Text(
      puntoVenta,
      style: TextStyle(
        fontFamily: 'Montserrat', //Cambiar font
        fontSize: 13.0,
        color: Colors.black,
      ),
    );
  }

  Container image() {
    return Container(
        width: 50,
        child: Image(image: AssetImage("assets/images/imagen_maps.png")));
  }

  void _mostrarAlerta(BuildContext context, PuntoVenta puntoVentas) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text("${puntoVentas.nombre.toUpperCase()}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("¿Atenderá el PDV?"),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Visita(
                                  contexts: contexts,
                                  puntoVenta: puntoVentas,
                                )));
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }
}
