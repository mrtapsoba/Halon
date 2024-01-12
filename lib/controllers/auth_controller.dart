import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppUser {
  final String uid;
  AppUser({
    required this.uid,
  });
}

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    return await _auth.signInWithCredential(credential);
  }

  Future deconnexion() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  AppUser? userFromFirebase(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(userFromFirebase);
  }

  Future verifedEmailLink() async {
    // Check if you received the link via `getInitialLink` first
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri? deepLink;
    if (initialLink != null) {
      deepLink = initialLink.link;
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        deepLink = pendingDynamicLinkData.link;
      },
    );

    // Confirm the link is a sign-in with email link.
    if (_auth.isSignInWithEmailLink(deepLink.toString())) {
      try {
        final String continueUrl =
            deepLink?.queryParameters['continueUrl'] ?? "";
        // The client SDK will parse the code from the link for you.
        await _auth.signInWithEmailLink(
            email: Uri.parse(continueUrl).queryParameters['email'] ?? "",
            emailLink: deepLink.toString());

        // You can access the new user via userCredential.user.
        //final emailAddress = userCredential.user?.email;

        print('Successfully signed in with email link!');
      } catch (error) {
        print('Error signing in with email link.');
      }
    }
  }
}
