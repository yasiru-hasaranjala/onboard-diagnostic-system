import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => MenuState();
}

class MenuState extends State<History> {
  final ref = FirebaseDatabase.instance.ref();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 36,
                  width: width*0.26,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade800,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Timestamp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width*0.22,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade800,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Distance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width*0.22,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade800,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Fuel Efficiency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width*0.22,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.teal.shade800,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Center(
                    child: Text(
                      "Fuel Consumption",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: ref.child("history").onValue,
                builder: (context, snap) {
                  if (snap.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  final data = snap.data?.snapshot.value as Map<dynamic, dynamic>;
                  List items = [];
                  data.forEach((index, data) => items.add({"key": index, ...data}));

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        title: Container(
                          child: row(items[index], width),
                        ),
                      );
                    },
                  );
              }
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        leading: const Icon(
          Icons.backpack_outlined,
          color: Colors.white,
        ),
        title: const Text('History', style: TextStyle(color: Colors.white70),),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: width-140.0),

        child: FloatingActionButton.extended(
          backgroundColor: Colors.black87,
          onPressed: (){
            Navigator.pop(context);
          },
          label: const Text('Back',style: TextStyle(color: Colors.white)),
          icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(0),
          child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Row row(final data,final width) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 28.5,
          width: width*0.26,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              data["timestamp"],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          width: width*0.22,
          height: 28.5,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              data["distance"].toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          width: width*0.22,
          height: 28.5,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              data["fuleEfficiency"].toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          width: width*0.22,
          height: 28.5,
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            borderRadius: BorderRadius.circular(3),
          ),
          child: Center(
            child: Text(
              data["fule_consuption"].toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}