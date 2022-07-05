import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/widgets/detailed_news.dart';
import 'package:provider/provider.dart';

class NewsInDetailScreen extends StatelessWidget {
  const NewsInDetailScreen({Key? key}) : super(key: key);
  static const routename = '/NewsDetail';

  @override
  Widget build(BuildContext context) {
    final detailNewsInfo =
        ModalRoute.of(context)!.settings.arguments as PassMultipleArgsToDetail;
    final detailedNews = Provider.of<NewsProvider>(context)
        .findById(detailNewsInfo.id, detailNewsInfo.category);
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: DetailedNews(detailedNews: detailedNews),
    );
  }
}
