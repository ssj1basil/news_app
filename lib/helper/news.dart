import 'package:flutter/foundation.dart';
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


  Future<List<articleModel>> get_newsByquery (String query) async{

    news = [];
    print(query);
    await get_news(query);

    return news;

  }

  Future<List<void>> get_news(String query ,{String Category = null, String Country = null, String sortby = null}) async {
    String url;

    if (query == null) {
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

       url =
          "https://newsapi.org/v2/top-headlines?country=$ISO&category=$Category&sortBy=$sortby&language=en&apiKey=f3727bbadb8e45d8b7441ecc62d6e2d2";
    }
    else
      { url = "https://newsapi.org/v2/everything?q=$query&apiKey=f3727bbadb8e45d8b7441ecc62d6e2d2";}


    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null && element['description'] != '') {
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
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                //to load an empty placeholder while image loads from the internet
                child: (FadeInImage.assetNetwork(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: 'assets/transparent.png',
                    image: imageurl))),
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.only(left: 4, right: 4, bottom: 10),
                child: Text(news_title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  news_desc,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ))
          ],
        ),
      ),
    );
  }
}
