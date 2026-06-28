import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Stream<User?> get authState => _auth.authStateChanges();
  Future<UserCredential> signIn(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);
  Future<UserCredential> register(String email, String password) => _auth.createUserWithEmailAndPassword(email: email, password: password);
  Future<void> resetPassword(String email) => _auth.sendPasswordResetEmail(email: email);
  Future<UserCredential> signInWithGoogle() async { final account = await GoogleSignIn().signIn(); final auth = await account!.authentication; return _auth.signInWithCredential(GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken)); }
  Future<void> logout() => _auth.signOut();
}
