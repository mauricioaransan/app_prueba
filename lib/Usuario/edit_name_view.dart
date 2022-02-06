import 'package:app_prueba/control_usuario/provider.dart';
import 'package:flutter/material.dart';

import '../home_widget.dart';

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  TextEditingController _userNameController = TextEditingController();
  String _errorName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.redAccent[400],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40.0, top: 10),
                  child: Row(
                    children: <Widget>[
                      Text('NOMBRE',
                          style: TextStyle(
                              fontFamily: 'Montserrat', //CAMBIO
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                      SizedBox(width: 10.0),
                      Text('De Usuario',
                          style: TextStyle(
                              fontFamily: 'Montserrat', //CAMBIO
                              color: Colors.white,
                              fontSize: 25.0))
                    ],
                  ),
                ),
                Container(
                    height: 660,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 125,
                    child: Container(
                        //borde circular
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.0)),
                            color: Colors.white),
                        height: 540,
                        width: MediaQuery.of(context).size.width)),
                Positioned(
                  top: 300,
                  left: 30,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 80,
                    padding: EdgeInsets.only(
                      top: 4,
                      left: 16,
                      right: 16,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 5),
                        ]),
                    child: TextField(
                        controller: _userNameController,
                        maxLength: 15,
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.deepOrange[500],
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          icon: Icon(Icons.perm_identity_rounded),
                          errorText: _errorName,
                          labelText: 'Nombre',
                        )),
                  ),
                ),
                Positioned(
                    top: 420,
                    left: 120,
                    //BOTON DEL EDIT
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            subirnombre();
                          });
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0.0, 20.0),
                                  blurRadius: 30,
                                  color: Colors.grey[400],
                                ),
                              ],
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(22.0)),
                          child: Row(children: <Widget>[
                            Container(
                              height: 50,
                              width: 100,
                              padding: EdgeInsets.only(top: 15, left: 8),
                              child: Text(
                                "EDITAR",
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
                              Icons.edit_rounded,
                              size: 30,
                            )
                          ]),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void subirnombre() async {
    if (_userNameController.text.length == 0) {
      _errorName = "Colocar el nombre";
    } else {
      try {
        final uid = await Provider.of(context).auth.getCurrentUser();
        final auth = Provider.of(context).auth;
        await auth.updateUserName(_userNameController.text, uid);
        Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
        _errorName = "";
      } catch (e) {
        print(e);
      }
    }
  }
}
