import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app_2022/controller/user_controller.dart';

import '../models/user.dart';

class Auth {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserController _userController = Get.put(UserController());

  get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    _auth.authStateChanges().listen((User? user) {
      if (user != null && googleUser != null) {
        MyUser userModel = MyUser(
            uid: user.uid,
            name: googleUser.displayName,
            email: googleUser.email,
            phone: 'phone',
            address: 'address',
            imageUrl: googleUser.photoUrl,
            isAdmin: false);
        createUser(userModel);

        _userController.myUser = userModel;
      }
    });
    return await _auth.signInWithCredential(credential);
  }

  Future createUser(MyUser user) async {
    _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<MyUser> getUser(String uid) async {
    DocumentSnapshot _doc = await _db.collection('users').doc(uid).get();
    final userModel = MyUser.fromDocumentSnapshot(snapshot: _doc);
    _userController.myUser = userModel;
    return MyUser.fromDocumentSnapshot(snapshot: _doc);
  }

  Future<void> updateUser(MyUser user) async {
    return await _db.collection('users').doc(user.uid).update(user.toMap());
    // DocumentSnapshot _doc = await _db.collection('users').doc(user.uid).update(user.toMap());
  }

  Future signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
