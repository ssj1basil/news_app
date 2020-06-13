import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'home.dart';
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

    /*Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[ Container(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: widgetarticle.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {*/
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
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                //to load an empty placeholder while image loads from the internet
                                child: (FadeInImage.assetNetwork(
                                    width: 100,
                                    height: 100 ,
                                    fit: BoxFit.cover,
                                    placeholder: 'assets/transparent.png',
                                    image: widget.article.urlToimage))),
                            Container(

                              width: text_width,
                                padding: EdgeInsets.only(left: 20, right: 4, bottom: 10),
                                child: Text(widget.article.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                    );
                //}),
       /*   ),
        ]
    )
    );*/

  }
}

