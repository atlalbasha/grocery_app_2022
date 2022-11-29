import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grocery_app_2022/controller/user_controller.dart';
import 'package:grocery_app_2022/models/user.dart';

class SocialAuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // userController.user['name'] = googleUser.displayName;
      // userController.user['email'] = googleUser.email;
      // userController.user['photoUrl'] = googleUser.photoUrl;
      // userController.user['uid'] = googleUser.id;
      // userController.user['photoUrl'] = googleUser.photoUrl;

      MyUser user = MyUser(
          uid: googleUser.id,
          name: googleUser.displayName,
          email: googleUser.email,
          phone: 'phone',
          address: 'address',
          imageUrl: googleUser.photoUrl,
          isAdmin: false);

      userController.createUser(user);
      //
    }

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

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future signOutGoogle() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
