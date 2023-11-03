import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:partice_fire1/main.dart';

import 'fourth.dart';

class third extends StatefulWidget {
  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  String mob = "";
  List val = [];
  List key = [];
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('student');

  @override
  void initState() {
    mob = first.prefs!.getString('contact') ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${mob}"),
        actions: [
          InkWell(
            onTap: () {
              first.prefs!.remove('status');
              first.prefs!.remove('status');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return first();
                },
              ));
            },
            child: Icon(Icons.remove_circle_outlined),
          )
        ],
      ),
      body: StreamBuilder(
          stream: starCountRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              starCountRef.onValue.listen((DatabaseEvent event) {
                final data = event.snapshot.value;
                Map m = data as Map;
                val = m.values.toList();
                key = m.keys.toList();
                setState(() {});
              });
            }

            if (val != null) {
              return ListView.builder(
                itemCount: val.length,
                itemBuilder: (context, index) {
                  print("Hello");
                  return (mob != val[index]['t1'])
                      ? Card(
                          child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return fourth(mob, val[index]['t2']);
                              },
                            ));
                          },
                          child: ListTile(
                            title: Text("${val[index]['t1']}"),
                          ),
                        ))
                      : Text("data");
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
