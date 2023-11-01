import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partice_fire1/main.dart';

void main() {
  runApp(MaterialApp(
    home: second(),
  ));
}

class second extends StatefulWidget {
  const second({super.key});

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: t1,
            decoration: InputDecoration(label: Text("Name")),
          ),
          TextField(
            controller: t2,
            decoration: InputDecoration(label: Text("Contact")),
          ),
          TextField(
            controller: t3,
            decoration: InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: t4,
            decoration: InputDecoration(label: Text("Password")),
          ),
          ElevatedButton(
              onPressed: () async {
                DatabaseReference ref =
                    FirebaseDatabase.instance.ref("student").push();

                await ref.set({
                  "t1": "${t1.text}",
                  "t2": "${t2.text}",
                  "t3": "${t3.text}",
                  "t4": "${t4.text}",
                });

                t1.text = "";
                t2.text = "";
                t3.text = "";
                t4.text = "";

                List name1=t1.value as List;
                String contact1=t2.value as String;
                print(1000);
              },
              child: Text("ADD")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return first();
                  },
                ));
              },
              child: Text("Done")),
        ],
      ),
    );
  }
}
