import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sftv1/home_page.dart';

import 'firebase_options.dart';
import 'login_page.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: login_page(),
      ));
    } else {
      runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: register_page(),
      ));
    }
  });
}

class register_page extends StatefulWidget {
  const register_page({Key? key}) : super(key: key);

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  @override
  TextEditingController _dateinput = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _UName = TextEditingController();
  bool _isLoading=false;
  //text editing controller for text field

  @override
  void initState() {
    super.initState();
    final usr1 = FirebaseAuth.instance.currentUser!;

    _email.text=usr1.email.toString();
    _UName.text=usr1.displayName.toString();
    _dateinput.text = ""; //set the initial value of text field

  }

  Widget build(BuildContext context) {
    final usr = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Register"),
            elevation: 0.0,
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(usr.photoURL!),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                   TextField(
                    controller: _UName,
                    decoration: const InputDecoration(
                      // icon: Icon(
                      //   Icons.account_circle,
                      //   size: 40.0,
                      //   color: Colors.blue,
                      // ),
                      // hintText: 'Enter Name',
                      helperText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      // icon: Icon(
                      //   Icons.mail,
                      //   size: 40.0,
                      //   color: Colors.blue,
                      // ),

                      // hintText:   ,
                      helperText: 'abc.gmailm.com',

                      border: OutlineInputBorder(),
                    ),
                    // onChanged: (email1) {
                    //   email.text=email1;
                    // },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                      controller: _dateinput,
                      decoration: const InputDecoration(
                        // icon:
                        //     Icon(
                        //         Icons.calendar_today,
                        //         size: 40.0,
                        //         color: Colors.blue,
                        //     ), //icon of text field

                        border: OutlineInputBorder(),
                        labelText: "yyyy-mm-dd", //label text of field
                        helperText: 'Birdth Date',
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000

                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            _dateinput.text =
                                formattedDate; //set output date to TextField value.
                            print(_dateinput.text);
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      // style: style,
                      onPressed: () {
                        setState(() {
                          _isLoading=true;
                          final db=FirebaseFirestore.instance;
                          String uid=usr.uid.toString();

                          // Create a new user with a first and last name
                          final user = <String, dynamic>{
                            "Nmae": _UName.text.toString(),
                            "Gmail": _email.text.toString(),
                            "BOD": _dateinput.text.toString(),
                            "Register_Staus": "true"
                          };

                          // Add a new document with a generated ID
                          db.collection("users").doc(usr.uid).set(user).onError((error, stackTrace) => print("Error writing document: $error"));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const home_page()),
                              ModalRoute.withName("/register_page")
                          );
                              // .then((DocumentReference doc) =>
                          // if(db.collection("users").doc(usr.uid).set(user).onError((error, stackTrace) => print("Error writing document: $error"))==!true){
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => const home_page()),
                          //       ModalRoute.withName("/register_page")
                          //   );
                          // }


                        });

                      },
                      child: const Text('Register'),
                    ),

                  ),
                  Container(
                    // padding: const EdgeInsets.all(50),
                    // margin:const EdgeInsets.all(50) ,
                    // color: Colors.blue[100],
//widget shown according to the state
                    child: Center(
                      child: !_isLoading
                          ?const Text("Loading Complete")
                          :const CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
    ;
  }


}
