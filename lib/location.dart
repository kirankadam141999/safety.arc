import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sftv1/login_page.dart';

void main(){
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:location()
  ));
}
class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  String _selectedValue = "USA";
  @override
  Widget build(BuildContext context) {
    String selectedValue = "USA";
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Safty.arc"),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
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
            SizedBox(height: 30),
            Text("chake avable zone",
              style: TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 30,
            ),),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton.icon(
                label: const Text(
                  "Auto Detect My location",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const login_page())
                      // ModalRoute.withName("/location")
                  );
                },
              ),
    ]
            ),
            SizedBox(
              height: 20,
            ),

        Container(
          padding: const EdgeInsets.all(50),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
                
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1),
               
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            dropdownColor: Colors.white,
              value: _selectedValue,

              onChanged: (String? newvalue){
              setState(() {

                _selectedValue = newvalue!;
                print(selectedValue);
            });

          },
            items: dropdownItems,
          ),
        )
          ],
        ),
      ),
    );




  }

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"),value: "USA"),
      DropdownMenuItem(child: Text("Canada"),value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
      DropdownMenuItem(child: Text("England"),value: "England"),


    ];
    // print(menuItems);
    return menuItems;
  }
}
