import 'package:app_prueba/productos/buildProductos.dart';
import 'package:flutter/material.dart';

class ListaProductProductos extends StatelessWidget {
  const ListaProductProductos(
      {Key key, @required List resultsList, @required String id})
      : _resultsList = resultsList,
        _id = id,
        super(key: key);

  final List _resultsList;
  final String _id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: ListView.builder(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 15),
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) =>
                  BuildProdCardProd(
                    contexts: context,
                    documents: _resultsList[index],
                    ids: _id,
                  ))),
    );
  }
}
