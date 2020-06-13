import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/helper/Drop_down_list.dart';
import 'package:newsapp/helper/category_list_maker.dart';
import 'package:newsapp/helper/get_country_list.dart';
import 'package:newsapp/helper/default_values.dart';
import 'package:newsapp/views/search_view.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //For categories displayed on top
  List<Category_model> category = new List<Category_model>();

  //For articles displayed on the horizontal list view
  List<articleModel> article = new List<articleModel>();

  //for loading icon
  bool _loading = true;

  //class object created to access static variables
   default_values drop_down_values = new default_values();


  String current_category; //the current category which the page is on

  //For sort by and country drop down list
  List<String> sortby_list ;
  String sortby_default_value ;
  List<String> country_list;
  String country_default_value ;


  //For search bar
  Icon cusIcon = Icon(Icons.search);


  @override
  void initState() {
    super.initState();

    sortby_list = ['Recent', 'Popularity'];

    //Get values from static class
    sortby_default_value = drop_down_values.get_sortby_value();
    country_default_value = drop_down_values.get_country_value();

    country_list = get_country_list();

    //Sort it by alphabetical order to show it on the dropdown list
    country_list.sort((a, b) => a.toString().compareTo(b.toString()));

    category = getcategories();

    current_category = 'business';
    getnews(current_category,country_default_value,sortby_default_value);
  }

  Future<void> refresh() async {
    _loading = true;
    country_default_value = drop_down_values.get_country_value();
    sortby_default_value = drop_down_values.get_sortby_value();
    getnews(current_category,country_default_value,sortby_default_value,);
    setState(() {});
  }

  getnews(String category,String ISO, String sortby) async {
    News newsclass = new News();
    await newsclass.get_news(null, Category : category,Country : ISO,sortby: sortby);
    article = newsclass.news;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[Text('Flutter'), Text('News', style: TextStyle(color: Colors.blue)), SizedBox(width: 75)],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchbar()));
            },
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                refresh();
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    /// Categories
                    children: <Widget>[
                      Container(
                        height: 70,
                        child: ListView.builder(
                            itemCount: category.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    bool _loading = true;
                                    current_category = category[index].categoryName;
                                    getnews(current_category,country_default_value,sortby_default_value);
                                    setState(() {
                                    });
                                  },
                                  child: categoryTile(category[index].ImageUrl, category[index].categoryName));
                            }),
                      ),

                      ///Sort by and Country
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text('Sort by:  ', style: TextStyle(fontWeight: FontWeight.w400)),
                              Container(
                                child: Dropdown_list(droplist: sortby_list, default_value: sortby_default_value,current_category: current_category,refresh: refresh,),
                              )
                            ]),
                            Row(children: <Widget>[
                              Text('Country:  ', style: TextStyle(fontWeight: FontWeight.w400)),
                              Container(
                                child: Dropdown_list(droplist: country_list, default_value: country_default_value,current_category: current_category,refresh: refresh,),
                              )
                            ]),
                          ],
                        ),
                      ),

                      ///Articles
                      Container(
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
                                    web_url: article[index].url);
                              }))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
