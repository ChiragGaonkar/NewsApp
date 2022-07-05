import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/widgets/nothing_here.dart';

class NewsProvider with ChangeNotifier {
  List<News>? _businessNews = []; //For Business News
  List<News>? _entertainmentNews = []; //For Entertainment News
  List<News>? _generalNews = []; //For General News
  List<News>? _healthNews = []; //For Health News
  List<News>? _scienceNews = []; //For Science News
  List<News>? _sportsNews = []; //For Sports News
  List<News>? _technologyNews = []; //For Technology News
  List<News>? _searchQueryNews = []; //For Searched News

  List<News> allNews(category) {
    if (category == 'business') {
      return [..._businessNews!];
    } else if (category == 'entertainment') {
      return [..._entertainmentNews!];
    } else if (category == 'general') {
      return [..._generalNews!];
    } else if (category == 'health') {
      return [..._healthNews!];
    } else if (category == 'science') {
      return [..._scienceNews!];
    } else if (category == 'sports') {
      return [..._sportsNews!];
    } else if (category == 'technology') {
      return [..._technologyNews!];
    } else if (category == 'search') {
      return [..._searchQueryNews!];
    }
    return [..._generalNews!];
  }

  News findById(newsId, category) {
    if (category == 'business') {
      return _businessNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'entertainment') {
      return _entertainmentNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'general') {
      return _generalNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'health') {
      return _healthNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'science') {
      return _scienceNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'sports') {
      return _sportsNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'technology') {
      return _technologyNews!.firstWhere((news) => news.id == newsId);
    } else if (category == 'search') {
      return _searchQueryNews!.firstWhere((news) => news.id == newsId);
    }
    return _generalNews!.firstWhere((news) => news.id == newsId);
  }

  Future<List<News>?> fetchAndAddNews(category, country, query) async {
    int count = 0;
    final url;
    if (query != "") {
      url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&language=en&apiKey=84f5eea7684e4366a68029423c059cb2',
      );
    } else {
      url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&language=en&apiKey=84f5eea7684e4366a68029423c059cb2',
      );
    }
    try {
      final response = await http.get(url);
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body);
      //print(extractedData);
      final totalResults = extractedData['totalResults'];
      final status = extractedData['status'];
      print(status);
      final articles = extractedData["articles"];
      List<News>? loadedNews = [];
      articles.forEach(
        (a) {
          if (a['author'] != null &&
              a['title'] != null &&
              a['description'] != null &&
              a['url'] != null &&
              a['urlToImage'] != null &&
              a['publishedAt'] != null &&
              a['content'] != null) {
            loadedNews.add(
              News(
                id: count++,
                status: status,
                author: a['author'],
                title: a['title'],
                description: a['description'],
                url: a['url'],
                urlToImage: a['urlToImage'],
                publishedAt: a['publishedAt'],
                content: a['content'],
              ),
            );
          }
        },
      );

      if (category == 'business') {
        _businessNews = loadedNews;
      } else if (category == 'entertainment') {
        _entertainmentNews = loadedNews;
      } else if (category == 'general') {
        _generalNews = loadedNews;
      } else if (category == 'health') {
        _healthNews = loadedNews;
      } else if (category == 'science') {
        _scienceNews = loadedNews;
      } else if (category == 'sports') {
        _sportsNews = loadedNews;
      } else if (category == 'technology') {
        _technologyNews = loadedNews;
      } else {
        _searchQueryNews = loadedNews;
      }
      // print(_news![6].id);
      notifyListeners();
    } catch (error) {
      print("Hello $error");
      rethrow;
    }
  }
}
