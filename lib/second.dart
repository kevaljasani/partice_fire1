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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("pic/1.jpg"), fit: BoxFit.fill)),
          child: Column(
            children: [
              TextField(
                controller: t1,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    label: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
              TextField(
                controller: t2,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    label: Text("Contact", style: TextStyle(fontSize: 20))),
              ),
              TextField(
                controller: t3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    label: Text("Email", style: TextStyle(fontSize: 20))),
              ),
              TextField(
                controller: t4,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    label: Text("Password", style: TextStyle(fontSize: 20))),
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
        ));
  }
}
