import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/color_gradient.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/screens/bookmark_screen.dart';
import 'package:newsapp/screens/search_screen.dart';
import 'package:newsapp/widgets/home_news_list.dart';
import 'package:newsapp/widgets/nothing_here.dart';
import 'package:provider/provider.dart';
import '../widgets/home_carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInit = true;
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading1 = true;
        _isLoading2 = true;
      });
      final fetchNews = Provider.of<NewsProvider>(context);
      fetchNews
          .fetchAndAddNews(
              "technology", "in", "") //Basically Indian Business news only.
          .then((_) {
        setState(() {
          _isLoading1 = false;
        });
      });
      fetchNews
          .fetchAndAddNews("general", "in", "") //Basically all Indian news.
          .then((_) {
        setState(() {
          _isLoading2 = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsProvider>(context);
    DateTime now = DateTime.now();
    String greet;
    var timeNow = int.parse(DateFormat('kk').format(now));
    if (timeNow >= 0 && timeNow < 12) {
      greet = "Good morning,";
    } else if (timeNow >= 12 && timeNow < 17) {
      greet = "Good afternoon,";
    } else {
      greet = "Good evening,";
    }

    return Scaffold(
      body: Container(
        decoration: customcgradientolor(Colors.white, Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greet,
                    style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMEd().format(now).toString(),
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            news.allNews('general').isEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Glance",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            _isLoading1
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : HomeCarouselSlider(
                    allNews: news.allNews('technology'),
                    category: 'technology',
                  ),
            const SizedBox(height: 20),
            news.allNews('general').isEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "Latest News",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
            _isLoading2
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : HomeNewsList(
                    allNews: news.allNews('general'),
                    category: 'general',
                  ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0x00000000),
        color: Theme.of(context).primaryColor,
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
