import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  final String text1, text2;
  const Titulo({
    Key key,
    @required this.text1,
    @required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.0, top: 10),
      child: Row(
        children: <Widget>[
          Text(text1,
              style: TextStyle(
                  fontFamily: 'Montserrat', //CAMBIO
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0)),
          SizedBox(width: 10.0),
          Text(text2,
              style: TextStyle(
                  fontFamily: 'Montserrat', //CAMBIO
                  color: Colors.white,
                  fontSize: 25.0)),
        ],
      ),
    );
  }
}

class BotonPrincipal extends StatelessWidget {
  final String textIcon;
  final IconData iconito;
  const BotonPrincipal({
    Key key,
    @required this.textIcon,
    @required this.iconito,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0.0, 20.0),
          blurRadius: 30,
          color: Colors.grey[400],
        ),
      ], color: Colors.grey[200], borderRadius: BorderRadius.circular(22.0)),
      child: Row(children: <Widget>[
        Container(
          height: 50,
          width: 100,
          padding: EdgeInsets.only(top: 15, left: 8),
          child: Text(
            textIcon,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.redAccent[400],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(95.0),
                bottomRight: Radius.circular(200.0),
                bottomLeft: Radius.circular(95.0),
              )),
        ),
        Icon(
          iconito,
          size: 30,
        )
      ]),
    );
  }
}

class BorderCircular extends StatelessWidget {
  final double alto;
  const BorderCircular({
    Key key,
    @required this.alto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0),
              topRight: Radius.circular(45.0),
            ),
            color: Colors.white),
        height: alto,
        width: MediaQuery.of(context).size.width);
  }
}

class Titulo2 extends StatelessWidget {
  final String text1;
  const Titulo2({
    Key key,
    @required this.text1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.0),
      child: Text(text1,
          style: TextStyle(
              fontFamily: 'Montserrat', //CAMBIO
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0)),
    );
  }
}
