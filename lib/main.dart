import 'package:flutter/material.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/providers/news_provider.dart';
import 'package:newsapp/screens/bookmark_screen.dart';
import 'package:newsapp/screens/category_screen.dart';
import 'package:newsapp/screens/news_detail_bookmark_screen.dart';
import 'package:newsapp/screens/news_in_detail_screen.dart';
import 'package:newsapp/screens/search_screen.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => NewsProvider()),
        ChangeNotifierProvider(create: (ctx) => BookMarkProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey,
          accentColor: Colors.white,
          brightness: Brightness.dark,
          fontFamily: 'Comfortaa',
          scaffoldBackgroundColor: const Color(0x00000000),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(color: Colors.white, fontSize: 16),
                bodyText2: const TextStyle(color: Colors.white, fontSize: 18),
                subtitle1: const TextStyle(color: Colors.white, fontSize: 13),
                headline1: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                //style: Theme.of(context).textTheme.bodyText1
              ),
        ),
        home: HomePage(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          BookmarkScreen.routeName: (ctx) => BookmarkScreen(),
          NewsInDetailScreen.routename: (ctx) => NewsInDetailScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          NewsDetailBookmarkScreen.routeName: (ctx) =>
              NewsDetailBookmarkScreen(),
        },
      ),
    );
  }
}
