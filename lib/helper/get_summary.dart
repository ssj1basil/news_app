import 'package:http/http.dart' as http;
import 'dart:convert';


Future<String> get_summary(String news_url) async {

  String url = "https://api.smmry.com/?SM_API_KEY=3F969FE7F9&SM_URL=$news_url";

  var response = await http.get(url);
  var jsonData = jsonDecode(response.body);

  return jsonData['sm_api_content'];
}