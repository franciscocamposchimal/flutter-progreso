import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      print('Error al crear cuenta...');
      return false;
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print('====AUTH EMAIL====');
      print(user);
      print('==================');
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      print('==== GOOGLE ====');
      print(res.user);
      print('==== GOOGLE ====');
      if (res.user == null)
        return false;
      else
        return true;
    } catch (e) {
      print("Error logging with google");
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      print("Exit..now go out!");
    } catch (e) {
      print("error logging out");
      print(e);
    }
  }
}
