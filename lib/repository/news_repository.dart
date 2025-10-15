import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api_app_bloc/Models/news_model.dart';

class NewsRepository {
  final String apiKey = 'c176639f5ddcc3a516b1144100ab7d69';

  Future<List<NewsArticle>> FetchData() async {
    final url = Uri.parse(
      'https://gnews.io/api/v4/top-headlines?lang=en&country=bd&topic=sports&max=20&apikey=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
