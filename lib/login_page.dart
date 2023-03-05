import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sftv1/register_page.dart';
import 'Project_Firebase.dart';

Future<void> main() async {
  // firebaseinitlize();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: login_page(),
  ));
}

class login_page extends StatelessWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Safty.arc"),
        elevation: 0.0,
      ),
      body:  Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
              child: const Text(
                "Wellcome to Saftey.arc",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              label: const Text(
                "Login with Google",
                style: TextStyle(
                    color:Colors.blue,
                    fontSize: 20
                ),
              ),
              icon: Image.asset(
                "assets/Google__G__Logo.svg.png",
                scale: 5,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: (){
                login_with_google();
                FirebaseAuth.instance
                    .idTokenChanges()
                    .listen((User? user) {
                  if (user != null) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const register_page()),
                        ModalRoute.withName("/login_page")
                    );
                  }
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
