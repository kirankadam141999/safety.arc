import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sftv1/register_page.dart';
import 'firebase_options.dart';
import 'login_page.dart';

int status=0;

// code for google sign in
Future<UserCredential> login_with_google() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

// run initializeApp method
Future<void> firebaseinitlize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
}


void chak_user_login(){
  var db = FirebaseFirestore.instance;
  final docRef = db.collection("users").doc("SF");

// Source can be CACHE, SERVER, or DEFAULT.
  const source = Source.cache;

  docRef.get(const GetOptions(source: source)).then(
        (res) => print("Successfully completed"),
    onError: (e) => print("Error completing: $e"),
  );
  if (FirebaseAuth.instance.currentUser != null) {
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: register_page(),
    ));
  }else{
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_page(),
    ));
  }
}