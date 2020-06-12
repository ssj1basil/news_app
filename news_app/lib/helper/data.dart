import 'package:newsapp/models/category_model.dart';
import 'package:flutter/material.dart';


//Contains the image and different categories for news

List<Category_model> getcategories(){

  List<Category_model> category = new List<Category_model>();
  Category_model category_model = new Category_model();

  //1
  category_model = new Category_model();
  category_model.categoryName = "Business";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  category.add(category_model);

  //2
  category_model = new Category_model();
  category_model.categoryName = "Entertainment";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(category_model);

  //3
  category_model = new Category_model();
  category_model.categoryName = "General";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
  category.add(category_model);

  //4
  category_model = new Category_model();
  category_model.categoryName = "Health";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  category.add(category_model);

  //5
  category_model = new Category_model();
  category_model.categoryName = "Science";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  category.add(category_model);

  //5
  category_model = new Category_model();
  category_model.categoryName = "Sports";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  category.add(category_model);

  //5
  category_model = new Category_model();
  category_model.categoryName = "Technology";
  category_model.ImageUrl = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(category_model);

  return category;

}