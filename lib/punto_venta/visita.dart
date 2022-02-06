import 'dart:io';

import 'package:app_prueba/Widgets/widgets.dart';
import 'package:app_prueba/modelos/puntoVenta.dart';
import 'package:app_prueba/productos/reportePrecios.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Visita extends StatefulWidget {
  @required
  final PuntoVenta puntoVenta;
  final BuildContext contexts;
  const Visita({Key key, this.contexts, this.puntoVenta}) : super(key: key);

  @override
  _VisitaState createState() => _VisitaState();
}

class _VisitaState extends State<Visita> {
  File _selectedPicture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Titulo2(
            text1: "Visita",
          ),
        ),
        backgroundColor: Color(0xFF21BFBD),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: <Widget>[
              SizedBox(height: 25.0),
              SizedBox(height: 40.0),
              Container(
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 70,
                      child: Column(
                        children: [
                          Text(
                            "${widget.puntoVenta.nombre.toUpperCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${widget.puntoVenta.calle}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          child: Center(
                            child: Icon(
                              Icons.photo_camera,
                              color: Colors.grey[700],
                              size: 50,
                            ),
                          ),
                        ),
                        onTap: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            _selectedPicture = image;
                          });
                        }),
                    (_selectedPicture != null)
                        ? Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            child: Image.file(_selectedPicture),
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportePrecios(
                                      puntoVenta: widget.puntoVenta,
                                    )));
                      },
                      child: BotonPrincipal(
                          textIcon: "Visitar",
                          iconito: Icons.location_on_outlined),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
