import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/color_gradient.dart';
import 'package:newsapp/models/convert_date_ago.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/providers/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedNews extends StatefulWidget {
  final News detailedNews;

  DetailedNews({
    required this.detailedNews,
  });

  @override
  State<DetailedNews> createState() => _DetailedNewsState();
}

class _DetailedNewsState extends State<DetailedNews> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    Widget dataToBePrinted(String heading, String data) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
            ),
            Text(data),
          ],
        ),
      );
    }

    final publishedTime = convertToAgo(
      DateTime.parse(widget.detailedNews.publishedAt.toString()),
    );

    return Container(
      decoration: customcgradientolor(Colors.pink, Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(
                  widget.detailedNews.urlToImage.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  publishedTime,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                IconButton(
                  onPressed: () {
                    //Bookmark functions will come here.
                    setState(() {
                      isBookmarked = true;
                    });
                    Provider.of<BookMarkProvider>(context, listen: false)
                        .addBookMarks(
                      DateTime.now(),
                      widget.detailedNews,
                    );
                  },
                  icon: isBookmarked
                      ? const Icon(Icons.bookmark_add)
                      : const Icon(Icons.bookmark_add_outlined),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(
                    color: Theme.of(context).primaryColor,
                    thickness: 4,
                  ),
                  Container(
                    width: size / 1.2,
                    child: Text(
                      widget.detailedNews.title.toString(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  dataToBePrinted(
                    "Brief Description",
                    widget.detailedNews.description.toString(),
                  ),
                  dataToBePrinted(
                    "Content",
                    widget.detailedNews.content.toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        String url = widget.detailedNews.url.toString();
                        //var urlLauchable = await canLaunchUrl(Uri.parse(url));
                        if (!await launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 30, left: 30),
                        child: Text(
                          "View full article",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
