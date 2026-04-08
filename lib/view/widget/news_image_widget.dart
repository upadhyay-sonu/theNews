import 'package:flutter/material.dart';

class NewsImageWidget extends StatelessWidget {
  final String? imageUrl;
  
  const NewsImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty || imageUrl == "--") {
      return _buildFallback();
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _buildImage(imageUrl!),
    );
  }

  Widget _buildImage(String url) {
    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: _buildLoading,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to proxy if first attempt fails and it's an HTTP URL
        if (!url.contains('corsproxy.io') && url.startsWith('http')) {
          return Image.network(
            "https://corsproxy.io/?$url",
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: _buildLoading,
            errorBuilder: (ctx, err, stack) => _fallbackContainer(),
          );
        }
        return _fallbackContainer();
      },
    );
  }

  Widget _buildLoading(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
              : null,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _fallbackContainer(),
    );
  }

  Widget _fallbackContainer() {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      child: const Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}
