import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/default_values.dart';

class Dropdown_list extends StatefulWidget {
  List<String> droplist;
  String default_value;
  String current_category;

  Dropdown_list({this.droplist, this.default_value, this.current_category, this.refresh});

  final AsyncCallback refresh;

  @override
  Dropdown_listState createState() => Dropdown_listState();
}

class Dropdown_listState extends State<Dropdown_list> {
  default_values values = new default_values();


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.default_value,
      icon: Icon(Icons.arrow_downward),
      iconSize: 17,
      elevation: 16,
      style: TextStyle(color: Colors.grey),
      onChanged: (String newValue) {
        setState(() {

          //Condition to know which dropdown values need to be changed sortby/country
          if (widget.droplist.contains(default_values.sortby_default_value)) {
            default_values.sortby_default_value = newValue;
          } else
           { default_values.country_default_value = newValue;}
          widget.default_value = newValue;

          //callback function to refresh the page
          widget.refresh();
        });
      },
      items: widget.droplist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
