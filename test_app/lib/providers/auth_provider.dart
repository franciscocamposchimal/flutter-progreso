import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_app/providers/firebase_provider.dart';
import 'package:test_app/utils/utils.dart' as utils;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //DB instance
  final FireStoreProvider _db = FireStoreProvider('users');

  Future<bool> signUp(String email, String password) async {
    utils.printDebug('$email and $password');
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      print('Error al crear cuenta...');
      utils.printError(e.toString());
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
      if (user != null){
        await _updateUserData(user);
        return true;
      } else {
        return false;
      }
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
      utils.printSuccess(res.user.email);
      print('==== GOOGLE ====');
      if (res.user == null) {
        return false;
      } else {
        await _updateUserData(res.user);
        utils.printSuccess('success insert...');
        return true;
      }
    } catch (e) {
      print("Error logging with google");
      utils.printError(e.toString());
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

  Future<String> getUrl() async {
    FirebaseUser user = await _auth.currentUser();
    return user.photoUrl;
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      utils.printError("Exit..now go out!");
    } catch (e) {
      print("error logging out");
      utils.printError(e.toString());
    }
  }

  Future _updateUserData(FirebaseUser user) async {
    utils.printSuccess('insert user ${user.uid}...');
    Map<String, dynamic> userToSend = {
      'uid': user.uid,
      'email': user.email,
      'photoURL': (user.photoUrl != null) ? user.photoUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s',
      'displayName': user.displayName,
      'timestamp': Timestamp.now()
    };
    await _db.update(userToSend, user.email);
  }
}
