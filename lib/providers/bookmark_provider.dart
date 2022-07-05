import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/bookmark.dart';
import 'package:newsapp/models/news.dart';

class BookMarkProvider with ChangeNotifier {
  List<BookMark> _bookmarks = [];

  List<BookMark> get bookmarkedNews {
    return [..._bookmarks];
  }

  News findBkmrkById(String index) {
    BookMark temp = _bookmarks.firstWhere((bkmk) => bkmk.id == index);
    return temp.bookmarkNews;
  }

  void addBookMarks(DateTime bkmkdate, News bkmkNews) {
    _bookmarks.add(
      BookMark(
        id: DateTime.now().toString(),
        bookmarkDate: bkmkdate,
        bookmarkNews: bkmkNews,
      ),
    );
    // FirebaseAuth.getCurrentUser
    // firebase connection collection "Bookmarks"

    notifyListeners();
  }

  void removeBookMarks(id) {
    _bookmarks.removeWhere((bkmrk) => bkmrk.id == id);
    notifyListeners();
  }
}
