import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partice_fire1/second.dart';
import 'package:partice_fire1/third.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: first(),
  ));
}

class first extends StatefulWidget {
  String? l;
  String? l1;

  first([this.l, this.l1]);

  static SharedPreferences? prefs;

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();

  @override
  void initState() {
    get();
  }

  get() async {
    first.prefs = await SharedPreferences.getInstance();

    if (first.prefs!.get('status') == true) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return third();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("pic/2.jpeg"), fit: BoxFit.fill)),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.black), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    label: Text("👤    Name", style: TextStyle(fontSize: 20))),
              ),
              SizedBox(
                child: TextField(
                  controller: contact,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: Colors.black), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      label: Text(
                        "📞    Contact",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  DatabaseReference starCountRef =
                      FirebaseDatabase.instance.ref('student');
                  starCountRef.onValue.listen((DatabaseEvent event) {
                    final data = event.snapshot.value;
                    Map m = data as Map;
                    List l = m.values.toList();

                    bool t = false;

                    for (int i = 0; i < l.length; i++) {
                      if (l[i]['name'] == name.text &&
                          l[i]['contact'] == contact.text) {
                        t = true;
                        break;
                      }
                    }

                    if (t == true) {
                      first.prefs!.setString('contact', contact.text);
                      first.prefs!.setBool('status', true);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return third();
                        },
                      ));
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Wrong...!"),
                            actions: [
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: Text("Ok")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: Text("Cancel"))
                                ],
                              )
                            ],
                          );
                        },
                      );
                    }
                  });
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return second();
                    },
                  ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    "New Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
