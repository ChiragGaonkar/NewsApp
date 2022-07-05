import 'news.dart';

class BookMark {
  DateTime bookmarkDate;
  News bookmarkNews;
  String id;
  BookMark({
    required this.id,
    required this.bookmarkDate,
    required this.bookmarkNews,
  });
}
