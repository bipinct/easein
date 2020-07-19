import 'package:easein/api/graphql_handler.dart';
import 'package:easein/home.dart';
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
  TextEditingController _text1 = new TextEditingController();
  TextEditingController _text2 = new TextEditingController();
  TextEditingController _text3 = new TextEditingController();
  TextEditingController _text4 = new TextEditingController();
  TextEditingController _text5 = new TextEditingController();
  TextEditingController _text6 = new TextEditingController();

  final ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Male', 'Female', 'Other'];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return

      Scaffold(
//        backgroundColor: Color(0xFF5c00d2),
        appBar: new AppBar(
          title: Text("Add Business"),
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  readOnly: false,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: 'businessName',
                        controller: _text1,
                        decoration: const InputDecoration(
                          labelText: 'Business name',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                           FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(2, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'address',
                        controller: _text2,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                           FormBuilderValidators.max(300),
                          FormBuilderValidators.minLength(2, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      FormBuilderPhoneField(
                        attribute: 'phone_number1',
                        controller: _text3,
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
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'email',
                        controller: _text4,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
//                          FormBuilderValidators.required(),
                           FormBuilderValidators.max(70),
                          FormBuilderValidators.minLength(5, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'about',
                        controller: _text5,
                        decoration: const InputDecoration(
                            labelText: 'About Business',
                            hintText:
                                "Example : Computer shop sales and services "),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
                          FormBuilderValidators.required(),
                           FormBuilderValidators.max(200),
                          FormBuilderValidators.minLength(4, allowEmpty: true),
                        ],
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15),
                      FormBuilderTextField(
                        attribute: 'cordinates',
                        controller: _text6,
                        decoration: const InputDecoration(
                          labelText: 'Location Coordinates',
                        ),
                        onChanged: _onChanged,
                        valueTransformer: (text) {
                          return text == null ? null : num.tryParse(text);
                        },
                        validators: [
//                          FormBuilderValidators.required(),
//                          FormBuilderValidators.numeric(),
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
                            loading = true;
                          });
                          if (_fbKey.currentState.saveAndValidate()) {
                            addBusinessAction();
                          } else {
                            setState(() {
                              loading = false;
                            });
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

  addBusinessAction() async {
    var result = await addBusiness(
      shopName: _text1.text,
      address: _text2.text,
      phone: _text3.text,
      email: _text4.text,
      about: _text5.text,
    );
    if(result != null ){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }else{

    }
    setState(() {
      loading= false;
    });

  }
}
