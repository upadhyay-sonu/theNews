import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newzzz/controller/fetchNews.dart';
import 'package:newzzz/model/newsArt.dart';
import 'package:newzzz/view/widget/NewsContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  bool hasError = false;
  late NewsArt newsArt;

  Future<void> GetNews() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
      });
      newsArt = await FetchNews.fetchNews();
    } catch (e) {
      print("Error fetching news: $e");
      hasError = true;
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
      appBar: AppBar(
        title: Text(
          "Today's Newsletter",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: GetNews,
          )
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Failed to load news."),
                        ElevatedButton(
                          onPressed: GetNews,
                          child: const Text("Retry"),
                        )
                      ],
                    ),
                  )
                : PageView.builder(
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value) {
                      GetNews();
                    },
                    itemBuilder: (context, index) {
                      return NewsContainer(
                        imgUrl: newsArt.imgUrl,
                        newsCnt: newsArt.newsCnt,
                        newsHead: newsArt.NewsHead,
                        newsDes: newsArt.newsDes,
                        newsUrl: newsArt.newsUrl,
                      );
                    },
                  ),
      ),
    );
  }
}
