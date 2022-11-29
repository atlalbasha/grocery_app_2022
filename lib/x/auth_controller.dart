import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/user_controller.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleAccount = Rx<GoogleSignInAccount?>(null);

  Rx<MyUser> user = MyUser().obs;

  final _userFirebase = Rxn<User>();
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;

  MyUser get myUser => user.value;
  set myUser(MyUser value) => user.value = value;

  User? get userFirebase => _userFirebase.value;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();

    _userFirebase.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    getUser();
  }

  getUser() async {
    _isLoading.value = true;
    try {
      print('press');
      DocumentSnapshot _doc =
          await _db.collection('users').doc(userFirebase!.uid).get();
      return MyUser.fromDocumentSnapshot(snapshot: _doc);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (googleUser != null) {
      googleAccount.value = googleUser;

      MyUser userModel = MyUser(
          uid: userFirebase!.uid,
          name: googleUser.displayName,
          email: googleUser.email,
          phone: 'phone',
          address: 'address',
          imageUrl: googleUser.photoUrl,
          isAdmin: false);
      createUser(userModel);

      myUser = userModel;
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future createUser(MyUser user) async {
    _isLoading.value = true;
    try {
      _db.collection('users').doc(userFirebase!.uid).set(user.toMap());
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
