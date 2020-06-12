import 'package:flutter/material.dart';


class categoryTile extends StatelessWidget {
  String imageurl, categoryName;

  categoryTile(String _URL, String _Name) {
    this.imageurl = _URL;
    this.categoryName = _Name;
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageurl, height: 65, width: 120, fit: BoxFit.cover)),
          Container(
            alignment: Alignment.center,
            height: 65,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black45,
            ),
            child: Text(categoryName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
