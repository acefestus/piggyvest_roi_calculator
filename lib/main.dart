import 'dart:ui';

import 'package:flutter/material.dart';

void main(){

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PiggyVest ROI Calculator',
      home: SIForm(),
      theme: ThemeData(
        primaryColor: Colors.blue
      ),

    )
  );
}

class SIForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _currencies = ['Naira', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;

  var _currentItemSelected = 'Naira';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController       = TextEditingController();
  TextEditingController termController      = TextEditingController();
  
  var displayResult = '';

  @override
  Widget build(BuildContext context) {

        
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Piggyvest ROI Calculator'),
      ),

      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[

            getImageAsset(),

          Padding(
            padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding) ,
            child:TextField(
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        controller: principalController,
        decoration: InputDecoration(
          labelText: 'Principal',
          hintText: 'Enter Principal e.g. 20000',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        )),

         Padding(
           padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding) ,
           child: TextField(
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          controller: roiController,
          decoration: InputDecoration(
          labelText: 'Rate of Interest',
          hintText: 'Rate in Percent',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        )),   
        
        Padding(
          padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
          child: Row(
          children: <Widget>[ 

         Expanded(child: TextField(
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          controller: termController,
          decoration: InputDecoration(
          labelText: 'Term',
          hintText: 'Time in Years',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        )),

        Container(width: _minimumPadding * 5,),

        Expanded(child: DropdownButton<String>(
          items: _currencies.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
              );
          }).toList(),

          value: _currentItemSelected,

          onChanged: (String newValueSelected) {

            _onDropDownItemSelected(newValueSelected);
          },
          ))
          
          
          ],
        )),
        
        Padding(
          padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
          child: Row(children: <Widget>[
        Expanded(
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Theme.of(context).primaryColorLight,
            child: Text('Calculate', textScaleFactor: 1.5,),
            onPressed: (){
              setState(() {
                this.displayResult = _calculateTotalReturns();
              });
            },
          ),
        ),

        Expanded(
          child: RaisedButton(
            color: Theme.of(context).primaryColorDark,
            textColor: Theme.of(context).primaryColorLight,
            child: Text('Reset', textScaleFactor: 1.5,),
            onPressed: (){
              setState(() {
                _reset();
              });
            },
          ),
        ),
        
        ],)),

        Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: Text(this.displayResult,),
          
        )
      

        ],
      ),
           

        ),
      );
  }

  Widget getImageAsset(){

    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(image: assetImage, width: 220.0, height: 42.0,);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns(){

    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term)/100;

    String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }
 
  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    
  }
 
 }