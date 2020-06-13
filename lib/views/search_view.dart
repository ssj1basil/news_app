import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:newsapp/helper/search_tiles_maker.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class searchbar extends StatefulWidget {
  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  @override
  final SearchBarController<articleModel> _searchBarController = SearchBarController();


  News newsclass = new News();

  Widget build(BuildContext context) {
    return (Scaffold(
        body: SafeArea(
      child: SearchBar<articleModel>(
        minimumChars: 3,
        hintText: 'Search',
        textStyle: TextStyle(),
        searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        headerPadding: EdgeInsets.symmetric(horizontal: 5),
        listPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
        onSearch: newsclass.get_newsByquery,
        searchBarController: _searchBarController,
        cancellationWidget: Text("Cancel"),
        emptyWidget: Text("empty"),
        indexedScaledTileBuilder: (int index) => ScaledTile.count(2,1),
        onCancelled: () {
          print("Cancelled triggered");
        },
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: 2,
        shrinkWrap: true,
        onItemFound: (articleModel article, int index ) {
          return category_view(article: article);
        },
      ),
    )));
  }
}
