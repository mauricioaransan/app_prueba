import 'package:app_prueba/Login/singin_view.dart';
import 'package:app_prueba/home_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'control_usuario/autenticacion.dart';
import 'control_usuario/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        auth: AuthService(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Prueba",
          theme: ThemeData(
            primarySwatch: Colors
                .blueGrey, //El Color de la barra de arriba incluído los íconos de las BottonBar
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signIn': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomeController(),
          },
        ));
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : LoginPage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
