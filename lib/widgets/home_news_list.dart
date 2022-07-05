import 'package:flutter/material.dart';
import 'package:newsapp/widgets/nothing_here.dart';
import '../models/news.dart';
import '../widgets/list_news.dart';

class HomeNewsList extends StatelessWidget {
  HomeNewsList({
    Key? key,
    required this.allNews,
    required this.category,
  }) : super(key: key);

  final List<News> allNews;
  String category;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 0),
        itemBuilder: (ctx, index) => ListNews(
          category: category,
          id: allNews[index].id,
          title: allNews[index].title!,
          imageUrl: allNews[index].urlToImage!,
          publishedDate: allNews[index].publishedAt!,
        ),
        itemCount: allNews.length,
      ),
    );
  }
}
