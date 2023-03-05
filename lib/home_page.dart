import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sftv1/login_page.dart';

import 'firebase_options.dart';

Future<void> main()  async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options:
  // DefaultFirebaseOptions.currentPlatform);

  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: login_page(),
      ));
    } else {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home_page(),
      ));
    }
  });

}



class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Safty.arc"),
        elevation: 0.0,
      ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      body: Container(
       child: Column(
         children: [
           ElevatedButton(

             onPressed: () async {
               await FirebaseAuth.instance.signOut();
               FirebaseAuth.instance
                   .idTokenChanges()
                   .listen((User? user) {
                 if (user == null) {
                   Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => const login_page()),
                       ModalRoute.withName("/home_page")
                   );
                 }
               });


             },
             child: Text("logo_out"),
           )
         ],
       ),
      )
    );
  }
}
