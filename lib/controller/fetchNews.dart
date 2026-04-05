//https://newsapi.org/v2/top-headlines?sources=google-news-in&apiKey=00e9bed3dc5e4229a937ad4ed362bed3
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:newzzz/model/newsArt.dart';


class FetchNews{

  static List sourcesID = [
    "abc-news",

    "bbc-news",
    "bbc-sport",

    "business-insider",

    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",

    "fox-news",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",

    "medical-news-today",

    "national-geographic",

    "news24",
    "new-scientist",

    "new-york-magazine",
    "next-big-future",

    "techcrunch",
    "techradar",

    "the-hindu",

    "the-wall-street-journal",

    "the-washington-times",
    "time",
    "usa-today",

  ];


  static Future<NewsArt> fetchNews() async {
    final _random = new Random();
    
    // We'll try up to 3 times to find a source that has articles
    for (int i = 0; i < 3; i++) {
        var sourceID = sourcesID[_random.nextInt(sourcesID.length)];
        print(sourceID);
        
        try {
            // Added CORS proxy for Web compatibility
            Response response = await get(Uri.parse(
              "https://corsproxy.io/?https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=00e9bed3dc5e4229a937ad4ed362bed3"
            ));
            
            if (response.statusCode == 200) {
              Map body_data = jsonDecode(response.body);
              List articles = body_data["articles"] ?? [];
              print(articles);

              if (articles.isNotEmpty) {
                  var myArticle = articles[_random.nextInt(articles.length)];
                  print(myArticle);
                  return NewsArt.fromAPItoApp(myArticle);
              }
            } else {
              print("API returned status code: ${response.statusCode}");
            }
        } catch (e) {
            print("Error fetching news: $e");
        }
    }
    
    // Fallback if no articles found after 3 tries or if API limit is reached
    return NewsArt(
        imgUrl: "https://wallpaperaccess.com/full/2112542.jpg",
        NewsHead: "No news available",
        newsDes: "We couldn't fetch the latest articles right now. Please try again later.",
        newsCnt: "We couldn't fetch the latest articles right now. Please try again later.",
        newsUrl: "https://news.google.com/"
    );
  }
}