
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

// Tener User ID
Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  // Tener CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  //agregar un UserName
  Future updateUserName(String name, User currentUser) async {    
    await currentUser.updateProfile(displayName: name);
    await currentUser.reload();
  }


  // Email & Contraseña Sign In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

}