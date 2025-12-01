import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'detail_view.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsHead;
  final String newsUrl;
  final String newsCnt;
  final String? author;
  final String? publishedAt;

  const NewsContainer({
    super.key,
    required this.imgUrl,
    required this.newsCnt,
    required this.newsHead,
    required this.newsUrl,
    this.author,
    this.publishedAt,
  });

  // Safe time parsing
  DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    try {
      return DateTime.parse(s).toLocal();
    } catch (_) {
      return null;
    }
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    return DateFormat('d MMM yyyy').format(dt);
  }

  String _formatTimeAgo(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('d MMM yyyy').format(dt);
  }

  // Safe trimming helper
  String _trimContent(String content, {int max = 500}) {
    if (content == "--") return content;
    if (content.length <= max) return content;
    return content.substring(0, max) + '...';
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? dateTime = _parseDate(publishedAt);
    final formattedTime = dateTime != null ? DateFormat('hh:mm a').format(dateTime) : '';
    final formattedDate = _formatDate(dateTime);
    final timeAgoOrDate = _formatTimeAgo(dateTime);
    final authorText = (author == null || author!.isEmpty) ? 'Unknown Author' : author!;

    // trimmed preview content (adjust max to show more)
    final previewContent = _trimContent(newsCnt, max: 600); // increase length here

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with share overlay; guard against empty image url
          Stack(
            children: [
              imgUrl.isNotEmpty
                  ? FadeInImage.assetNetwork(
                placeholder: 'assets/img/error_placeholder.png',
                image: imgUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/img/error_placeholder.png',
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                'assets/img/error_placeholder.png',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: Colors.white),
                    onPressed: () {
                      Share.share('$newsHead\nRead more at: $newsUrl');
                    },
                  ),
                ),
              ),
            ],
          ),

          // Meta info
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              '$authorText • $timeAgoOrDate',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),

          // Headline + content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsHead.length > 120 ? '${newsHead.substring(0, 120)}...' : newsHead,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // Use rich Text + "Read more" button instead of unsafe substrings
                Text(
                  previewContent,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailViewScreen(newsUrl: newsUrl),
                      ),
                    );
                  },
                  child: const Text('Read More'),
                ),
              ],
            ),
          ),

          // Credit
          Center(
            child: TextButton(
              onPressed: () async {
                final uri = Uri.parse('https://newsapi.org/');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: const Text(
                'News Provided By NewsAPI.org',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
