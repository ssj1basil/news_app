/*
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'home.dart';
import 'package:newsapp/helper/news.dart';

class category_view extends StatefulWidget {

  final String category;
  category_view({this.category});
  @override
  _category_viewState createState() => _category_viewState();
}

class _category_viewState extends State<category_view> {

  List<articleModel> article = new List<articleModel>();
  bool _loading = true;


  void initState(){
    super.initState();
    get_category_news();
  }

  get_category_news() async {
    CategoryNews newsclass = new CategoryNews();
    await newsclass.get_category_news(widget.category);
    article = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
      body:SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[ Container(
            padding: EdgeInsets.only(top: 16),
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: article.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return news_tile(
                      imageurl: article[index].urlToimage,
                      news_title: article[index].title,
                      news_desc: article[index].description,
                      web_url: article[index].url
                  );
                }),
          ),
        ]),
      ),)
    );
  }
}
*/
