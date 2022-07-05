import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsapp/models/convert_date_ago.dart';
import 'package:newsapp/models/pass_multiple_args.dart';
import 'package:newsapp/screens/news_in_detail_screen.dart';
import 'package:newsapp/widgets/nothing_here.dart';
import '../models/news.dart';

class HomeCarouselSlider extends StatelessWidget {
  final List<News> allNews;
  String category;
  HomeCarouselSlider({
    required this.allNews,
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return allNews.isEmpty
        ? const Center(child: NothingHere())
        : CarouselSlider.builder(
            itemCount: allNews.length,
            itemBuilder: (context, index, realIndex) {
              final title = allNews[index].title.toString();
              final imageUrl = allNews[index].urlToImage.toString();
              final publishedDate = allNews[index].publishedAt.toString();
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        NewsInDetailScreen.routename,
                        // arguments: allNews[index].id,
                        arguments: PassMultipleArgsToDetail(
                          id: allNews[index].id,
                          category: category,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: NetworkImage(
                            imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 20),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 120,
                      color: Colors.black54,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        convertToAgo(DateTime.parse(publishedDate)),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ],
              );
            },
            options: CarouselOptions(
              height: 220,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.easeInOut,
              reverse: true,
              viewportFraction: 0.8,
            ),
          );
  }
}
