import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  get userid {
    if (_auth.currentUser == null) {
      return '';
    } else {
      return _auth.currentUser!.uid;
    }
  }

  //SIGN UP METHOD
  Future signUpUser({
    String? email,
    String? password,
    String? name,
    String? userType,
  }) async {
    try {
      print(email);
      await _auth
          .createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!,
      )
          .then((value) async {
        final CollectionReference usersRef =
            FirebaseFirestore.instance.collection("users");

        await usersRef.doc(value.user!.uid).set({
          'userid': value.user!.uid,
          'name': name,
          'email': email,
          'password': password,
          'userType': userType,
          'avatarUrl': '',
        });
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN UP METHOD
  Future signUpDriver({
    String? email,
    String? password,
    String? name,
    String? userType,
  }) async {
    try {
      print(email);
      await _auth
          .createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!,
      )
          .then((value) async {
        final CollectionReference usersRef =
            FirebaseFirestore.instance.collection("users");

        await usersRef.doc(value.user!.uid).set({
          'userid': value.user!.uid,
          'name': name,
          'email': email,
          'password': password,
          'userType': userType,
          'avatarUrl': '',
        });
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN UP METHOD
  Future signUpVendor({
    String? email,
    String? password,
    String? name,
    String? userType,
  }) async {
    try {
      print(email);
      await _auth
          .createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!,
      )
          .then((value) async {
        final CollectionReference usersRef =
            FirebaseFirestore.instance.collection("users");

        await usersRef.doc(value.user!.uid).set({
          'userid': value.user!.uid,
          'name': name,
          'email': email,
          'password': password,
          'userType': userType,
          'avatarUrl': '',
          'physicalAddress': {},
          'mapAddress': {},
          'workingHours': {},
          'workPlaceImage': '',
          'daysVisitors': '00',
          'daysEarnings': '0.00',
        });
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
