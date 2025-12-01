import 'dart:convert';

class NewsArt {
  String imgUrl;
  String newsHead;
  String newsCnt;
  String newsUrl;
  String author;
  String publishedAt;

  NewsArt({
    required this.author,

    required this.publishedAt,
    required this.imgUrl,
    required this.newsCnt,

    required this.newsHead,
    required this.newsUrl,
  });

  static NewsArt fromAPItoApp(Map<String, dynamic> article) {
    return NewsArt(
      imgUrl:
          article["urlToImage"] ??
          "https://img.freepik.com/free-vector/breaking-news-concept_23-2148514216.jpg?w=2000",
      newsCnt: article["content"] ?? "--",
      newsHead: article["title"] ?? "--",
      newsUrl:
          article["url"] ??
          "https://news.google.com/topstories?hl=en-IN&gl=IN&ceid=IN:en",
      author: article['author'],
      publishedAt: article['publishedAt'],
    );
  }
}
