import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final FirebaseFirestore fStore = FirebaseFirestore.instance;
  User? get currentUser => fAuth.currentUser;
  Stream<User?> get authStateChanges => fAuth.authStateChanges();

// Sign in to the account
  Future signIn(String email, String password) async {
    try {
      await fAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

// Sign out to the account
  Future signOut() async {
    try {
      await fAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Register the User
  Future userRegister(
    String userName,
    String email,
    String password,
  ) async {
    try {
      // Create user
      await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Add user details
      await fStore
          .collection("user")
          .add({"user_name": userName, "user_email": email});
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
