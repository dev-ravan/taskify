import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/common/constants.dart';

class AuthRepo {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final FirebaseFirestore fStore = FirebaseFirestore.instance;
  User? get currentUser => fAuth.currentUser;
  Stream<User?> get authStateChanges => fAuth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        getUserData();
      });
    } on FirebaseAuthException catch (e) {
      log("Firebase Authentication Error: ${e.message}");
    } catch (e) {
      log('Error: $e');
    }
  }

// Get User Data
  Future<void> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection("user");
    QuerySnapshot<Object?> userData = await userCollection
        .where("user_email", isEqualTo: currentUser!.email)
        .get();

    // Create a list to store the retrieved data
    List<Map<String, dynamic>> userDataList = [];

    userData.docs.map((d) {
      Map<String, dynamic> data = d.data() as Map<String, dynamic>;

      // Add the current document data to the list
      userDataList.add(data);
    }).toList();

    // Now you can use the userDataList as needed
    // For example, you can access the first document's user_name like this:
    String userName = userDataList.first['user_name'];

    // Strore the value with key
    pref.setString("user_name", userName);

    // get the data using key
    globalUserName = pref.getString("user_name")!;
    log(globalUserName);
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
