import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth fb = FirebaseAuth.instance;
  final FirebaseFirestore fStore = FirebaseFirestore.instance;
  User? get currentUser => fb.currentUser;
  Stream<User?> get authStateChanges => fb.authStateChanges();

// Sign in to the account
  Future signIn(String email, String password) async {
    try {
      await fb.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

// Sign out to the account
  Future signOut() async {
    try {
      await fb.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // Register the User
  Future userRegister(String email, String password, String userName) async {
    try {
      // Create user
      await fb.createUserWithEmailAndPassword(email: email, password: password);

      // Add user details
      await fStore.collection("user").add(
        {"user_name": userName, "user_email": email},
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
