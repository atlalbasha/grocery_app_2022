import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';
import '../services/auth.dart';
import '../services/firestore_db.dart';

class UserController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //RxMap<dynamic, dynamic> user = {}.obs;
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  final _userFirebase = Rxn<User>();
  User? get userFirebase => _userFirebase.value;
  //
  var editUser = {}.obs;
  Rx<MyUser> user = MyUser().obs;
  MyUser get myUser => user.value;
  set myUser(MyUser value) => user.value = value;

  @override
  void onReady() async {
    _userFirebase.bindStream(Auth().authStateChanges);
    getUser();
  }

  @override
  void onInit() async {
    super.onInit();
    getUser();
  }

  signInWithGoogle() async {
    _isLoading.value = true;
    try {
      await Auth().signInWithGoogle();
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  createUser(MyUser user) async {
    _isLoading.value = true;
    try {} catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  updateUser(MyUser user) async {
    _isLoading.value = true;
    try {
      await Auth().updateUser(user);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  getUser() async {
    _isLoading.value = true;
    try {
      await Auth().getUser(userFirebase!.uid.toString());
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
