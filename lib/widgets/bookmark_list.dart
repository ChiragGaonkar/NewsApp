import 'package:flutter/material.dart';
import 'package:newsapp/models/convert_date_ago.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:newsapp/screens/news_detail_bookmark_screen.dart';
import 'package:provider/provider.dart';

class BookMarkList extends StatelessWidget {
  final String imageUrl;
  final String publishedDate;
  final String title;
  final String id;
  BookMarkList({
    required this.id,
    required this.imageUrl,
    required this.publishedDate,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          NewsDetailBookmarkScreen.routeName,
          arguments: PassMultipleArgsToBookmark(index: id),
        );
      },
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                "Delete",
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        direction: DismissDirection.startToEnd,
        confirmDismiss: (direction) {
          return showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (ctx) => Container(
              height: MediaQuery.of(context).size.height * 0.35,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xFF303443),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delete my Bookmark",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    "Are you sure you want to delete the news you've bookmarked before?",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ),
          );
        },
        onDismissed: (_) {
          Provider.of<BookMarkProvider>(context).removeBookMarks(id);
        },
        child: Card(
          color: const Color(0xFF303443),
          margin: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 5,
                height: 125,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 125,
                width: size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // if the text is in row/col use expanded to resolve text overflwing
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    Text(
                      convertToAgo(DateTime.parse(publishedDate)),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 125,
                width: size.width * 0.3,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
