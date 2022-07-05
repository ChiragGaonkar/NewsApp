import 'package:flutter/material.dart';
import 'package:newsapp/models/convert_date_ago.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/screens/news_in_detail_screen.dart';

class ListNews extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String publishedDate;
  String category;

  ListNews({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.publishedDate,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          NewsInDetailScreen.routename,
          arguments: PassMultipleArgsToDetail(
            id: id,
            category: category,
          ),
        );
      },
      child: Card(
        color: const Color(0xFF303443),
        margin: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              height: 125,
              width: size.width * 0.3,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
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
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    convertToAgo(DateTime.parse(publishedDate)),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
