import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_api_app_bloc/Models/news_model.dart';

class NewsRepository {
  final String apiKey = 'bdcdfa6f7312b84091f93222d2d34044';

  Future<List<NewsArticle>> fetchNews({String? category}) async {
    final url = Uri.parse(
      'https://gnews.io/api/v4/top-headlines?lang=en&country=us&max=10&apikey=$apiKey${category != null ? '&category=$category' : ''}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = (data['articles'] as List)
          .map((e) => NewsArticle.fromJson(e))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}
