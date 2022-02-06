import 'package:app_prueba/home_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_prueba/modelos/producto.dart';
import 'package:app_prueba/modelos/puntoVenta.dart';
import 'package:app_prueba/productos/listProductos.dart';
import '../Widgets/widgets.dart';

class ReportePrecios extends StatefulWidget {
  final PuntoVenta puntoVenta;
  const ReportePrecios({
    Key key,
    @required this.puntoVenta,
  }) : super(key: key);
  @override
  _ReportePreciosState createState() => _ReportePreciosState();
}

class _ReportePreciosState extends State<ReportePrecios> {
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getProductosStreamSnapshot();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  getProductosStreamSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection("punto_venta")
        .doc(widget.puntoVenta.documentID)
        .collection("productos")
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return "complete";
  }

  searchResultsList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var prodSnapshot in _allResults) {
        var title = Producto.fromSnapshot(prodSnapshot).nombre;
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(prodSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF21BFBD),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 25.0),
              Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.only(top: 10),
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (contexts) => Home()));
                      }),
                  Titulo(
                    text1: "Reporte",
                    text2: "Precios",
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Container(
                  height: 620,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(75.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 20, top: 10),
                        child: TextField(
                          controller: _searchController,
                          decoration:
                              InputDecoration(prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      ListaProductProductos(
                          resultsList: _resultsList,
                          id: widget.puntoVenta.documentID),
                    ],
                  )),
            ],
          )),
    );
  }
}
