import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sftv1/location.dart';
import 'Project_Firebase.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  chak_user_login();
  // runApp(const MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: location(),
  // ));
}

