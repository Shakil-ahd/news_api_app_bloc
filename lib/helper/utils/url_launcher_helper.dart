import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherHelper {
  static Future<void> launchURL(BuildContext context, String url) async {
    print('URL tapped: $url');
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open article')));
    }
  }
}
