import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newzzz/view/detail_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsHead;
  final String newsDes;
  final String newsUrl;
  final String newsCnt;
  
  const NewsContainer({
    super.key,
    required this.imgUrl,
    required this.newsDes,
    required this.newsCnt,
    required this.newsHead,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50], // Light mode background
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Builder(
                      builder: (context) {
                        if (imgUrl.isEmpty || imgUrl == "--") {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          );
                        }
                        // Wrap the URL with a proxy designed exactly to fix Flutter Web CORS rendering blocks
                        String safeUrl = imgUrl.startsWith('http') 
                           ? "https://corsproxy.io/?$imgUrl"
                           : imgUrl;

                        return Image.network(
                          safeUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                            );
                          },
                        );
                      }
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsHead,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        newsDes,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        newsCnt != "--"
                            ? (newsCnt.length > 250
                                ? "${newsCnt.substring(0, 250)}..."
                                : newsCnt)
                            : "No detailed content available.",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              final Uri url = Uri.parse("https://newsapi.org/");
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            icon: const Icon(Icons.info_outline, size: 16),
                            label: const Text(
                              "NewsAPI.org",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailViewScreen(newsUrl: newsUrl),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              "Read More",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
