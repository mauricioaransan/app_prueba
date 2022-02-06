import 'package:flutter/material.dart';
import 'buildPuntoVenta.dart';

class ListaProduct extends StatelessWidget {
  const ListaProduct({
    Key key,
    @required List resultsList,
  })  : _resultsList = resultsList,
        super(key: key);

  final List _resultsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: ListView.builder(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 15),
              itemCount: _resultsList.length,
              itemBuilder: (BuildContext context, int index) => BuildProdCard(
                    contexts: context,
                    documents: _resultsList[index],
                  ))),
    );
  }
}
