import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DynamicLinkService {
  static const String defaultFallbackUrl =
      'https://youtube.com/@mr-dark99x?si=Zz-iOqE_qEDbZJya';
  static const String cachedVideoUrlKey = 'cached_dynamic_video_url';

  // Default Public JSONBin Bin ID for MR DARK dynamic link
  static const String jsonBinUrl =
      'https://api.jsonbin.io/v3/b/66db8f97ad19ca34f8a1db5b/latest';

  /// Fetches latest video URL from JSONBin and caches locally.
  /// Returns cached or fallback URL on error.
  static Future<String> getVideoUrl() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http
          .get(Uri.parse(jsonBinUrl))
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          final record = data['record'];
          if (record is Map<String, dynamic>) {
            final videoUrl = record['video_url']?.toString();
            if (videoUrl != null && videoUrl.isNotEmpty) {
              await prefs.setString(cachedVideoUrlKey, videoUrl);
              return videoUrl;
            }
          }
        }
      }
    } catch (_) {
      // Ignore network errors and fallback to cache
    }

    // Return cached URL if available
    final cached = prefs.getString(cachedVideoUrlKey);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    return defaultFallbackUrl;
  }
}
