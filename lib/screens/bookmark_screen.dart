import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/color_gradient.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/screens/search_screen.dart';
import 'package:newsapp/widgets/bookmark_list.dart';
import 'package:newsapp/widgets/nothing_here.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);
  static const routeName = 'bookmark';

  @override
  Widget build(BuildContext context) {
    final bookmarkedNews =
        Provider.of<BookMarkProvider>(context).bookmarkedNews;
    return Scaffold(
      body: Container(
        decoration: customcgradientolor(Colors.deepPurpleAccent, Colors.black),
        child: bookmarkedNews.isEmpty
            ? const Center(
                child: NothingHere(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 70, left: 10, bottom: 5),
                    child: Text(
                      "Bookmark",
                      style: TextStyle(
                        fontSize: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemCount: bookmarkedNews.length,
                      itemBuilder: (context, index) {
                        var temp = bookmarkedNews[index].bookmarkNews;
                        return BookMarkList(
                          id: bookmarkedNews[index].id,
                          imageUrl: temp.urlToImage.toString(),
                          publishedDate: temp.publishedAt.toString(),
                          title: temp.title.toString(),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0x00000000),
        color: Theme.of(context).primaryColor,
        index: 2,
        onTap: (index) {
          //Navigation Code here.
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          } else if (index == 1) {
            Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
          } else if (index == 2) {
            Navigator.of(context)
                .pushReplacementNamed(BookmarkScreen.routeName);
          }
        },
        items: [
          Icon(
            Icons.home,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.bookmark_added_rounded,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
