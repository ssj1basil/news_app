import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsapp/models/article_model.dart';
import '../views/home.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/views/article_view.dart';

class category_view extends StatefulWidget {
  articleModel article;

  category_view({this.article});

  @override
  _category_viewState createState() => _category_viewState();
}

class _category_viewState extends State<category_view> {
  @override
  Widget build(BuildContext context) {
    double text_width = MediaQuery.of(context).size.width * 0.6;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => article_view(
                      web_url: widget.article.url,
                    )));
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    //to load an empty placeholder while image loads from the internet
                    child: (FadeInImage.assetNetwork(
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: 'assets/transparent.png',
                        image: widget.article.urlToimage)))),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  width: text_width,
                  padding: EdgeInsets.only(left: 20, right: 4, bottom: 10),
                  child: Text(widget.article.title, overflow : TextOverflow.fade,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
              Container(
                  width: text_width,
                  height: 65,
                  padding: EdgeInsets.only(left: 20, right: 4, bottom: 10),
                  child: Text(
                    widget.article.description,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
