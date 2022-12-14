import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// void main() {
//   runApp(AddVaccinePage());
// }

class AddVaccinePage extends StatelessWidget {
  const AddVaccinePage({Key? key}) : super(key : key);
  static const String _title = '新增疫苗';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: new Scaffold(
        body: new AddVaccine(),
      ),
    );
  }
}


class AddVaccine extends StatefulWidget {
  const AddVaccine({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _AddVaccine();
  }
}

class _AddVaccine extends State<AddVaccine> {
  final TextEditingController _vaccineController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _vaccineFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  // Map<String, dynamic> _editTodo = {
  //   'type': '',
  //   'expense': '',
  //   'date': '',
  //   'description':'',
  //   'done': false,
  // };
  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
  _submitForm() {
    if (_formKey.currentState!.validate()) {
        final vaccine_record = {
          'name': _vaccineController.text,
          'date': _dateController.text,
          'note': _descriptionController.text,
        };
        print(vaccine_record.toString());

        // If the form passes validation, display a Snackbar.

        // final snackBar = SnackBar(
        //     content: const Text('紀錄已儲存'),);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        _formKey.currentState!.save();
        _formKey.currentState!.reset();
        _nextFocus(_vaccineFocusNode);
      }
  }
  String? _validateInput(String value) {
      if(value.trim().isEmpty) {
      return 'Field required';
    }
    return null;
  }


  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    _vaccineController.text = "";
    _descriptionController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();

    super.dispose();
  }
  //
  // void _saveForm() {
  //   final isValid = _formKey.currentState.validate();
  //   if (isValid) {
  //     _formKey.currentState.save();
  //     print(_editTodo['type']);
  //     print(_editTodo['expense']);
  //     print(_editTodo['date']);
  //     print(_editTodo['description']);
  //     final Todo newTodo = Todo(
  //       type: _editTodo['type'],
  //       expense: _editTodo['expense'],
  //       date: _editTodo['date'],
  //       description: _editTodo['description'],
  //       done: false,
  //     );
  //     Provider.of<Todos>(context, listen: false).addTodo(newTodo);
  //     Navigator.of(context).pop();
  //   }
  // }


  //const AddExpense({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(60.0),
        child: Form(
          key: _formKey,
          //child: Padding(
          //height: 1000,
            // flightShuttleBuilder: (BuildContext flightContext,
            //     Animation<double> animation,
            //     HeroFlightDirection flightDirection,
            //     BuildContext fromHeroContext,
            //     BuildContext toHeroContext,)
            // {
            //   return SingleChildScrollView(
            //     child: fromHeroContext.widget,
            //   );
            // },
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text('增加',
                            style: TextStyle(fontSize: 24,)
                        ),
                      ),
                    ),

                    Divider(
                      color: Colors.grey[400],
                      height: 10,
                      thickness: 2,
                    ),

                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('疫苗', style: TextStyle(fontSize: 20,)),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            focusNode: _vaccineFocusNode,
                            onFieldSubmitted: (String value) {
                              //Do anything with value
                              _nextFocus(_dateFocusNode);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              hintText: '輸入疫苗名稱',
                              hintStyle: const TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _vaccineController,
                            keyboardType: TextInputType.text,

                          ),

                        ),


                      ],
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('日期', style: TextStyle(fontSize: 20,)),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            focusNode: _dateFocusNode,
                            onFieldSubmitted: (String value) {
                              //Do anything with value
                              _nextFocus(_descriptionFocusNode);
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              hintText: '選擇施打日期',
                              hintStyle: const TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            controller: _dateController,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  _dateController.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              }
                              else {}
                            },
                          ),

                        ),

                      ],
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    //Container(
                    //height: 100,
                    //child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('備註', style: TextStyle(fontSize: 20,)),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            focusNode: _descriptionFocusNode,
                            onFieldSubmitted: (String value) {
                              //Do anything with value
                              _submitForm();
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              hintText: '有什麼想備註的嗎？',
                              hintStyle: const TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            //expands: true,
                          ),
                        ),


                      ],
                    ),

                    //),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    ElevatedButton(
                      onPressed: () {
                        _submitForm();
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('紀錄已儲存')));
                        }
                      },
                      child: const Text('送出', style: TextStyle(fontSize: 20),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            //),

          //),
        ),
      ),


    );


  }
}