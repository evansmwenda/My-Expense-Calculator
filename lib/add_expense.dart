import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AddExpense extends StatefulWidget {
  static const routeName = '/add-expense';
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var myFormat = DateFormat('d-MM-yyyy');

  int _value = 1;
  String _chosenValueAir;
  TextEditingController _dateController;

  final myController = TextEditingController();
  final _amountController = TextEditingController();
  final _detailsController = TextEditingController();
  final name = "Name";
  // DateTime selectedDate =  DateFormat("dd-MM-yyyy").format(DateTime.now());

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    _dateController = new TextEditingController(text: '${myFormat.format(selectedDate)}');
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 30.0),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      focusColor: Colors.green,
                      value: _chosenValueAir,
                      //elevation: 5,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.blue,
                      items: <String>[
                        'Fare',
                        'Food',
                        'Credo',
                        'Clothing',
                        'EGW Books',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Select Category",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValueAir = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 50,
                  // margin: EdgeInsets.all(
                  //   10.0,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Stack(
                    children: <Widget>[
                      TextFormField(
                        controller: _amountController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          labelText: "Expense Amount",
                          contentPadding: EdgeInsets.symmetric(
                            // vertical: 5.0,
                            horizontal: 5.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter expense amount';
                          }
                        },
                      ),
                      Positioned(
                        bottom: 1,
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.blue
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    height: 50,
                    // margin: EdgeInsets.all(
                    //   10.0,
                    // ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: Stack(
                      children: <Widget>[
                        IgnorePointer(
                          child: TextFormField(
                            cursorColor: Colors.blue,
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: "Expense Date",
                              contentPadding: EdgeInsets.symmetric(
                                // vertical: 5.0,
                                horizontal: 5.0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.blue
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Stack(
                    children: <Widget>[
                      TextFormField(
                        controller: _detailsController,
                        maxLines: 5,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          labelText: "Any Additional details",
                          contentPadding: EdgeInsets.symmetric(
                            // vertical: 5.0,
                            horizontal: 5.0,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        child: Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.blue
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue),
                      ),
                      color: Colors.blue[700],
                      textColor: Colors.white,
                      // padding: EdgeInsets.symmetric(
                      //     vertical: 12.0, horizontal: 40.0),
                      onPressed: () {
                        _saveFormData();
                      },
                      child: SizedBox(
                        width: 107,
                        height: 39,
                        child: Center(
                          child: Text(
                            "Continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveFormData() {
    //fetch data from controllers
    if(_chosenValueAir == null || _chosenValueAir.isEmpty ||  _amountController.text.isEmpty){
      //display error message
      print("we have an empty field");
      Toast.show("Error, please fill all fields before submitting", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

    }else{
      //upload to firebase
      print(_chosenValueAir);
      print(_amountController.text);
      print(_dateController.text);
      print(_detailsController.text);
      FirebaseFirestore.instance
          .collection('expense')
          .add({
        'amount': _amountController.text,
        'category': _chosenValueAir,
        'date': _dateController.text,
        'description': _detailsController.text,});

      Toast.show("Expense added successfully!", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      clearInputFields();
      _formKey.currentState?.reset();
    }
    // if (_formKey.currentState.validate()) {
    //   // //checks if name and amount entered,date is by default->check category
    //   if(_chosenValueAir == null || _chosenValueAir.isEmpty){
    //     print("saving form data");
    //     print("saving form data");
    //   }
    // }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateController.clear();
    _amountController.clear();
    _detailsController.clear();
    super.dispose();
  }

  void clearInputFields() {
    _amountController.clear();
    _dateController.clear();
    _detailsController.clear();
    setState(() {
      print("redrawing the activity");
      _amountController.clear();
      _dateController.clear();
      _detailsController.clear();
    });

  }
}

class Expense {
  final String name;
  final int votes;
  final DocumentReference reference;

  Expense.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Expense.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  void save() => print("Record<$name:$votes>");
}


