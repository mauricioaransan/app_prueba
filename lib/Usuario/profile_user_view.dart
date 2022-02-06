import 'package:app_prueba/Usuario/edit_name_view.dart';
import 'package:app_prueba/Widgets/widgets.dart';
import 'package:app_prueba/control_usuario/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF21BFBD),
        body: SafeArea(
          child: ListView(children: [
            SizedBox(
              height: 40,
            ),
            Titulo(text1: "PERFIL", text2: "Usuario"),
            SizedBox(height: 40.0),
            Stack(
              children: [
                BorderCircular(alto: 569.5),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: _circleAvatar()),
                    ),
                    buildCardUser(),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditName()));
                              },
                              child: BotonPrincipal(
                                  textIcon: "EDITAR",
                                  iconito: Icons.edit_rounded)),
                          InkWell(
                              onTap: () {
                                final auth = Provider.of(context).auth;
                                auth.signOut();
                              },
                              child: BotonPrincipal(
                                  textIcon: "SALIR",
                                  iconito: Icons.highlight_off)),
                        ])
                  ],
                ),
              ],
            ),
          ]),
        ));
  }

  Card buildCardUser() {
    return Card(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Container(
                  width: 90,
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        textIzq("Nombre"),
                        SizedBox(height: 10),
                        textIzq("Correo"),
                        SizedBox(height: 10),
                        textIzq("Fec. Crea."),
                        SizedBox(height: 10),
                      ]),
                ),
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return userInformation(context, snapshot);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Widget _circleAvatar() {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 5),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/perfil_usuario.jpg"),
        ), // Decoration image
      ), // Box decoration
    ); // Container
  }
}

showSignOut(context) async {
  try {
    await Provider.of(context).auth.signOut();
  } catch (e) {
    print(e);
  }
}

Widget userInformation(context, snapshot) {
  final user = snapshot.data;
  String usuario;
  if (user.displayName == null) {
    usuario = "No Registrado";
  } else {
    usuario = user.displayName;
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        textDer(usuario),
        SizedBox(height: 10),
        textDer(user.email),
        SizedBox(height: 10),
        textDer(
          DateFormat('dd/MM/yyyy')
              .add_jms()
              .format(user.metadata.creationTime)
              .toString(),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

textDer(String textos) {
  return Container(
    height: 20,
    child: Text(textos,
        style: TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
  );
}

textIzq(String texto) {
  return Container(
    height: 20,
    child: Text(texto,
        style: TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 14.0,
          color: Colors.grey[600],
        )),
  );
}
