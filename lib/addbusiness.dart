import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'data.dart';

class AddBusiness extends StatefulWidget {
  @override
  _AddBusinessState createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
//        backgroundColor: Color(0xFF5c00d2),
        appBar: new AppBar(
          title: Text("Add a Business"),
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                FormBuilder(
                  // context,
                  key: _fbKey,
                  // autovalidate: true,
                  initialValue: {
                    'movie_rating': 3,
                  },
                  readOnly: false,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: 'businessName',
                        decoration: const InputDecoration(
                          labelText: 'Business name',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(2, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'address',
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(2, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      FormBuilderPhoneField(
                        attribute: 'phone_number1',
//                        initialValue: '+91',
                        // defaultSelectedCountryIsoCode: 'KE',
                        cursorColor: Colors.black,
                        // style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        onChanged: _onChanged,
                        defaultSelectedCountryIsoCode: "IN",
                        priorityListByIsoCode: ['IN'],
                        validators: [
                          FormBuilderValidators.numeric(
                              errorText: 'Invalid phone number'),
                          FormBuilderValidators.required(
                              errorText: 'This field reqired'),
                          FormBuilderValidators.minLength(10, allowEmpty: false)
                        ],
                      ),
                      SizedBox(height: 15),

                      FormBuilderTextField(
                        attribute: 'email',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(5, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'about',
                        decoration: const InputDecoration(
                          labelText: 'About Business',
                          hintText: "Example : Computer shop sales and services "
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(4, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'cordinates',
                        decoration: const InputDecoration(
                          labelText: 'Location Coordinates',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                          // FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(2, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            loading= true;
                          });
                          if (_fbKey.currentState.saveAndValidate()) {



//                            print(_fbKey.currentState.value['contact_person']
//                                .runtimeType);
//                            print(_fbKey.currentState.value);
                          } else {
//                            print(_fbKey.currentState.value['contact_person']
//                                .runtimeType);
//                            print(_fbKey.currentState.value);
//                            print('validation failed');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _fbKey.currentState.reset();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          loading
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Wrap()
        ]));
  }

//  async addBusiness()
}
