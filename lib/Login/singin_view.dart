import 'package:app_prueba/control_usuario/provider.dart';
import 'package:flutter/material.dart';
import 'logotipo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  String _errorMail, _errorPassword, _errorLogin = " ";
  final formKey = GlobalKey<FormState>();
  void submit() async {
    final state = formKey.currentState;
    state.save();
    this._errorMail = null;
    _errorPassword = null;
    _errorLogin = " ";
    if (_email.length == 0 && _password.length == 0) {
      _errorMail = "Colocar el Correo";
      _errorPassword = "Colocar la Contraseña";
    } else if (_email.length == 0) {
      _errorMail = "Colocar el Correo";
    } else if (_password.length == 0) {
      _errorPassword = "Colocar la Contraseña";
    } else {
      try {
        final auth = Provider.of(context).auth;
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print(uid);
        Navigator.of(context).pushReplacementNamed('/home');
        _errorPassword = null;
        _errorMail = null;
        _errorLogin = " ";
      } catch (e) {
        print(e);
        _errorLogin = "Usuario no Registrado";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formKey,
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/fondo.jpg"),
                  fit: BoxFit.cover),
            ),
            child: ListView(
              children: <Widget>[
                //LOGOTIPO
                Logotipo(),
                SizedBox(height: 80),
                //Contenedor de usuario y contra
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      //USUARIO
                      userYPass(
                          context,
                          _errorMail,
                          "Usuario",
                          Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          false),
                      SizedBox(height: 25),
                      //CONTRA
                      userYPass(
                          context,
                          _errorPassword,
                          "Contraseña",
                          Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          true),
                      SizedBox(height: 15),
                      Container(
                        child: Text(_errorLogin,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0)),
                      ),
                      SizedBox(height: 80),
                      //BOTON
                      botonLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container botonLogin() {
    return Container(
      width: 150.0,
      height: 50.0,
      child: new RaisedButton(
          child: new Text(
            "INGRESAR",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.black87,
          color: Colors.orangeAccent,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          onPressed: () {
            setState(() {
              submit();
            });
          }),
    );
  }

  Container userYPass(BuildContext context, String error, String hintText,
      Icon icon, bool boolean) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      padding: EdgeInsets.only(
        top: 4,
        left: 16,
        right: 16,
        bottom: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ]),
      child: TextFormField(
        obscureText: boolean,
        decoration:
            InputDecoration(errorText: error, icon: icon, hintText: hintText),
        onSaved: (val) => boolean == false ? _email = val : _password = val,
      ),
    );
  }
}
