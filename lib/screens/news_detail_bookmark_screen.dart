import 'package:flutter/material.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/widgets/detailed_news.dart';
import 'package:provider/provider.dart';

class NewsDetailBookmarkScreen extends StatelessWidget {
  static const routeName = '/detailedbookmark';

  @override
  Widget build(BuildContext context) {
    final detailedInfo = ModalRoute.of(context)!.settings.arguments
        as PassMultipleArgsToBookmark;
    final detailedNews = Provider.of<BookMarkProvider>(context)
        .findBkmrkById(detailedInfo.index);
    return Scaffold(
      body: DetailedNews(detailedNews: detailedNews),
    );
  }
}
