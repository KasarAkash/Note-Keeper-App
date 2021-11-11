import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static late String uid;
  static late String email;

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    uid = googleUser!.id;
    email = googleUser.email;

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static String getUID() {
    return uid;
  }

  static String getEmail() {
    return email;
  }
}
