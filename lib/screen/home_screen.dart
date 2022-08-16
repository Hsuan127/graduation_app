import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/hospital_records.dart';
import 'package:flutter_app/screen/signin_screen.dart';
import 'package:flutter_app/utils/flutterfire.dart';

import 'hospital_history_screen.dart';

class HomeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot> userInfo =
  FirebaseFirestore.instance.collection('user_info').snapshots();

  //final String uid = (FirebaseAuth.instance.currentUser.uid).toString();
  //final Stream<QuerySnapshot> name =
  //FirebaseFirestore.instance.collection('users').doc(getUid()).collection('name').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter_app Bar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              child: Text("Hospital Records"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HHistoryScreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Vaccine Records"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HHistoryScreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Health Records"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HHistoryScreen()));
              },
            ),SizedBox(
              height: 20,
            ),
            ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  });
                })
          ],
        ),
      ),
    );
  }
}

