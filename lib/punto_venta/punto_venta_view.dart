import 'package:app_prueba/modelos/puntoVenta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'listPuntoVenta.dart';
import '../Widgets/widgets.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    var data = await FirebaseFirestore.instance.collection("punto_venta").get();
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
        var title = PuntoVenta.fromSnapshot(prodSnapshot).nombre;
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
              Titulo(
                text1: "Punto",
                text2: "de Venta",
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
                      ListaProduct(resultsList: _resultsList),
                    ],
                  )),
            ],
          )),
    );
  }
}
