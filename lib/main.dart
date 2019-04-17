import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Dollar', 'Rupees', 'Pounds'];
  final _minpadding = 5.0;
  var _currentitemselected = '';

  void initState() {
    super.initState();
    _currentitemselected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
            padding: EdgeInsets.all(_minpadding * 2),
//        margin: EdgeInsets.all(_minpadding),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please enter principal amount';
                        }

                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter Principal e.g. 12000',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please enter rate of intrest';
                        }

                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          hintText: 'In percent',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          validator: (String value){
                            if(value.isEmpty){
                              return 'Please enter time duration in years';
                            }
                            if(value.length>12){
                              return 'Enter valid value';

                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Time',
                              hintText: 'Time in years',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minpadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                          value: _currentitemselected,
                          onChanged: (String newValueSelected) {
                            _DropDownitemselected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColor,
                              child: Text(
                                'Calculate',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {

                                setState(() {
                                  if(_formkey.currentState.validate()) {
                                    this.displayResult =
                                        _calculatetotalreturn();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Reset',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              }),
                        )
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minpadding * 10),
    );
  }

  void _DropDownitemselected(String newValueSelected) {
    setState(() {
      this._currentitemselected = newValueSelected;
    });
  }

  String _calculatetotalreturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentitemselected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentitemselected = _currencies[0];
  }
}
