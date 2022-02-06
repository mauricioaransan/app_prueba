
import 'package:flutter/material.dart';

class Logotipo extends StatelessWidget {
  const Logotipo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 77.0),
      child: new CircleAvatar(
        backgroundColor: Color(0xF81F7F3),
        child: new Image(
          width: 135,
          height: 135,
          image: new AssetImage("assets/images/usuario.png"),
        ),
      ),
      width: 170.0,
      height: 170.0,
      decoration: BoxDecoration(shape: BoxShape.circle),
    );
  }
}

