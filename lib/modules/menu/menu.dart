import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => MenuState();
}

class MenuState extends State<Menu> {
  final ref = FirebaseDatabase.instance.ref('live_data');

  final _auth = FirebaseAuth.instance;
  late User loggedinUser;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: const Text(
            'Onboard Diagnostic System',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/bike.png', scale: 2.3,),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Fuel Efficency :", style: TextStyle(fontSize: 22,)),
                    StreamBuilder(
                      stream: ref.child('fuleEfficiency').onValue,
                      builder: (context, snap) {
                        if (snap.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        String effi = snap.data!.snapshot.value.toString();
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          ),
                          onPressed: () {},
                          child: Text("$effi KM/L", style: TextStyle(fontSize: 20,))
                        );
                      }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Fuel Consumption :", style: TextStyle(fontSize: 22,)),
                    StreamBuilder(
                        stream: ref.child('fule_consuption').onValue,
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          String con = snap.data!.snapshot.value.toString();
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              ),
                              onPressed: () {},
                              child: Text("$con L", style: TextStyle(fontSize: 20,))
                          );
                        }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Distance :", style: TextStyle(fontSize: 22,)),
                    StreamBuilder(
                        stream: ref.child('distance').onValue,
                        builder: (context, snap) {
                          if (snap.hasError) {
                            return Text('Something went wrong');
                          }
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          String effi = snap.data!.snapshot.value.toString();
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.deepOrangeAccent,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              ),
                              onPressed: () {},
                              child: Text("$effi KM", style: TextStyle(fontSize: 20,))
                          );
                        }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: const Text("Log out", style: TextStyle(fontSize: 25,)),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: (){
            Navigator.pushNamed(context, 'history_screen');
          },
          label: const Text('History',style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.logout, color: Colors.white,),
        ),
      ),
    );
  }
}