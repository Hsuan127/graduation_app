import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/signin_screen.dart';
import '../utils/hospital_records.dart';
import '../utils/spend_records.dart';

class SHistoryScreen extends StatefulWidget {

  @override
  State<SHistoryScreen> createState() => _SHistoryScreenState();
}

class _SHistoryScreenState extends State<SHistoryScreen> {
  List<Object> _historylist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSpendingRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Records'),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 40.0),
            child: GestureDetector(
              onTap: (){

              },
              child: Icon(Icons.history),
            ),)
        ],
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                        itemCount: _historylist.length,
                        itemBuilder: (context, index) {
                          return Text('$index');
                        }),
                  ),
                  MyCustomForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getSpendingRecords() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('pet1ID')
        .doc()
        .collection('Spending Records')
        .orderBy('created', descending: true)
        .get();
    setState(() {
      _historylist =
          List.from(data.docs.map((doc) => SpendRecords.fromSnapshot(doc)));
    });
  }
}

class MyCustomForm extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();

  SpendRecords spendRecord = SpendRecords();

  TextEditingController _category = TextEditingController();
  var spend = 0;
  var date = '';
  var note = '';
  var created = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _fromKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money),
                    hintText: 'What\'s the category?',
                    labelText: 'Category',
                  ),
                  onChanged: (value) {
                    _category.text = value;
                    spendRecord.category = _category.text;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Type Something';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.question_mark),
                    hintText: 'How much did you spend?',
                    labelText: 'Amount',
                  ),
                  onChanged: (value) {
                    spend = int.parse(value);
                    spendRecord.spend = spend;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Type Something';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'When?',
                    labelText: 'Date',
                  ),
                  onChanged: (value) {
                    date = value;
                    spendRecord.date = date; // actually should be datetime type
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Type Something';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.note),
                    hintText: 'Anything else?',
                    labelText: 'Notes',
                  ),
                  onChanged: (value) {
                    note = value;
                    spendRecord.note = note;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Type Something';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_fromKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sending Data to Cloud Firestore'),
                          ),
                        );
                        spendRecord.created = created;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('pet1ID')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('Spending Records')
                            .add(spendRecord.toJson());
                      }
                      //_name.clear(); not work
                    },
                    child: Text('Submit'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
        ));
  }
}
