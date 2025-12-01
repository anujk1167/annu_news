import 'package:flutter/material.dart';
import 'package:annu_news/controllers/fetch_news.dart';
import 'package:annu_news/model/news_art.dart';
import 'package:annu_news/widgets/news_container.dart';
import 'header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  NewsArt? newsArt; // make nullable

  // Fetch news safely
  Future<void> GetNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      NewsArt? fetchedNews = await FetchNews.fetchNews();

      setState(() {
        newsArt = fetchedNews;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching news: $e');
      setState(() {
        newsArt = null;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    GetNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32), // for safe area
          NewsHeaderBar(
            onCategorySelected: (selected) {
              print("Selected category: $selected");
            },
          ),
          const SizedBox(height: 2),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                GetNews();
              },
              itemBuilder: (context, index) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (newsArt == null) {
                  return const Center(child: Text("No news available."));
                }

                return NewsContainer(
                  imgUrl: newsArt!.imgUrl ?? "",
                  newsCnt: newsArt!.newsCnt ?? "--",
                  newsHead: newsArt!.newsHead,
                  newsUrl: newsArt!.newsUrl ?? "",
                  author: newsArt!.author,
                  publishedAt: newsArt!.publishedAt,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
