import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/helper/get_country_list.dart';


//Extracts JSON data from the https url

class News {

  //Map countries with their ISO code
  Map get_map(List<String> x, List<String> y) {
    var z = new Map<String, String>();

    for (var i = 0; i < x.length; i++) {
      z[x[i]] = y[i];
    }
    return z;
  }

  List<articleModel> news = [];

  Future<void> get_news(String Category, String Country, String sortby) async {

    List<String> country_list = get_country_list();
    List<String> ISO_list = get_ISO();
    Map<String, String> map_to;
    map_to = get_map(ISO_list, country_list);

    String ISO;

    //find the correspong ISO for the country
    ISO = map_to.keys.firstWhere((k) => map_to[k] == Country, orElse: () => null);

    //Recent is not a valid API parameter so changing it to publishedat
    if (sortby == 'Recent') {
      sortby = 'publishedAt';
    }

    String url =
        "https://newsapi.org/v2/top-headlines?country=$ISO&category=$Category&sortBy=$sortby&language=en&apiKey=f3727bbadb8e45d8b7441ecc62d6e2d2";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          articleModel article = articleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToimage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class news_tile extends StatelessWidget {
  String imageurl, news_title, news_desc, web_url;

  news_tile({this.imageurl, this.news_title, this.news_desc, this.web_url});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => article_view(
                      web_url: web_url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.network(imageurl)),
            SizedBox(
              height: 8,
            ),
            Text(news_title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 8,
            ),
            Text(news_desc)
          ],
        ),
      ),
    );
  }
}
