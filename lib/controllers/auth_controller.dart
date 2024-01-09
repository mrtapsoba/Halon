import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  Future<UserCredential> signInWithGoogle() async {
    //final googleProvider = GoogleAuthProvider();
    //return await FirebaseAuth.instance.signInWithProvider(googleProvider);

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deconnexion() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
