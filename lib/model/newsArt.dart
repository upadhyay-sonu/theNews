class NewsArt{
  String imgUrl;
  String NewsHead;
  String newsDes;
  String newsUrl;
  String newsCnt;

  NewsArt({

    required this.imgUrl,
    required this.NewsHead,
    required this.newsCnt,
    required this.newsDes,
    required this.newsUrl
});

  static NewsArt fromAPItoApp(Map<String, dynamic >article){
    return NewsArt(imgUrl: article["urlToImage"] ?? "https://wallpaperaccess.com/full/2112542.jpg",
        NewsHead: article["title"] ?? "--",
        newsCnt: article["content"] ?? "--",
        newsDes: article["description"] ?? "--",
        newsUrl: article["url"] ?? "https://news.google.com/search?for=headlines&hl=en-IN&gl=IN&ceid=IN%3Aen");
  }
}