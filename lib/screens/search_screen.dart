import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/color_gradient.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/screens/category_screen.dart';

import 'bookmark_screen.dart';
import 'home_page.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';

  Widget categoryCards(
    String categoryType,
    String imgAssets,
    BuildContext context,
  ) {
    var categoryName;
    if (categoryType == 'business') {
      categoryName = 'Business';
    } else if (categoryType == 'technology') {
      categoryName = 'Technology';
    } else if (categoryType == 'sports') {
      categoryName = 'Sports';
    } else if (categoryType == 'entertainment') {
      categoryName = 'Entertainment';
    } else if (categoryType == 'health') {
      categoryName = 'Health';
    } else if (categoryType == 'science') {
      categoryName = 'Science';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CategoryScreen.routeName,
            arguments: PassMultipleArgsToCategory(
              category: categoryType,
              query: "",
            ),
          );
        },
        child: Container(
          // height: ,
          // width: MediaQuery.of(context).size.width *,
          child: Card(
            color: const Color(0xFF303443),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset(imgAssets),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      categoryName,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void searchNews(query, _textController, context) {
    //updating value of query to users favorite topic.
    query = _textController.text;
    FocusManager.instance.primaryFocus?.unfocus(); //to dismiss keyboard.
    Navigator.of(context).pushNamed(
      CategoryScreen.routeName,
      arguments: PassMultipleArgsToCategory(
        category: "search",
        query: query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //use this controller to keep track what user is typing
    final _textController = TextEditingController();
    //Store user text input into variable
    String query = '';

    return Scaffold(
      body: Container(
        decoration: customcgradientolor(Colors.purpleAccent, Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 70, left: 10, bottom: 5),
              child: Text(
                "Search",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                textInputAction: TextInputAction.search,
                maxLength: 20,
                controller: _textController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF303443),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Find you favorite topic",
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      _textController.clear();
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      //updating value of query to users favorite topic.
                      searchNews(query, _textController, context);
                    },
                  ),
                ),
                onSubmitted: (_) {
                  searchNews(query, _textController, context);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top Categories",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                padding: const EdgeInsets.all(0.0),
                children: [
                  categoryCards(
                      "business", "assets/images/business.png", context),
                  categoryCards(
                      "technology", "assets/images/technology.png", context),
                  categoryCards("sports", "assets/images/sports.png", context),
                  categoryCards("entertainment",
                      "assets/images/entertainment.png", context),
                  categoryCards("health", "assets/images/health.png", context),
                  categoryCards(
                      "science", "assets/images/science.png", context),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0x00000000),
        color: Theme.of(context).primaryColor,
        index: 1,
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
