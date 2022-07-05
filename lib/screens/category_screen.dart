import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/widgets/home_news_list.dart';
import 'package:newsapp/widgets/nothing_here.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routeName = '/categoryType.category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<News> allNews = [];
  void didChangeDependencies() {
    final categoryType = ModalRoute.of(context)!.settings.arguments
        as PassMultipleArgsToCategory;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final categoricalNews = Provider.of<NewsProvider>(context);
      categoricalNews
          .fetchAndAddNews(categoryType.category, "in", categoryType.query)
          .then((_) {
        setState(() {
          allNews = categoricalNews.allNews(categoryType.category);
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoryType = ModalRoute.of(context)!.settings.arguments
        as PassMultipleArgsToCategory;
    var categoryName;
    if (categoryType.category == 'business') {
      categoryName = 'Business';
    } else if (categoryType.category == 'technology') {
      categoryName = 'Technology';
    } else if (categoryType.category == 'sports') {
      categoryName = 'Sports';
    } else if (categoryType.category == 'entertainment') {
      categoryName = 'Entertainment';
    } else if (categoryType.category == 'health') {
      categoryName = 'Health';
    } else if (categoryType.category == 'science') {
      categoryName = 'Science';
    } else if (categoryType.category == 'search') {
      categoryName = categoryType.query;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(239, 98, 159, 1),
                  Color.fromRGBO(238, 205, 163, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            categoryName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : allNews.isEmpty
              ? const NothingHere()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    HomeNewsList(
                        allNews: allNews, category: categoryType.category),
                  ],
                ),
    );
  }
}
